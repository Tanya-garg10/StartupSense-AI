import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'startup_analysis_service.dart';

class StartupAnalysisEndpoint extends Endpoint {
  static final _analysisService = StartupAnalysisService();

  @override
  bool get requireLogin => true;

  Future<AnalysisResponse> analyzeIdea(
    Session session,
    StartupIdeaRequest idea,
  ) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StartupSenseError(
        code: 'authentication_required',
        message: 'Sign in to create and save an analysis.',
      );
    }
    final validatedIdea = _validateIdea(idea);
    final now = DateTime.now().toUtc();
    final pendingRecord = await StartupAnalysisRecord.db.insertRow(
      session,
      StartupAnalysisRecord(
        authUserId: authUserId,
        startupName: validatedIdea.startupName,
        industry: validatedIdea.industry,
        stage: validatedIdea.stage,
        ideaJson: jsonEncode(validatedIdea.toJson()),
        reportJson: '',
        analysisMode: _analysisService.mode,
        status: 'processing',
        createdAt: now,
      ),
    );

    final id = pendingRecord.id;
    if (id == null) {
      throw StartupSenseError(
        code: 'persistence_failed',
        message: 'The analysis could not be saved. Please try again.',
      );
    }
    late final AnalysisReport report;
    late final StartupAnalysisRecord record;
    try {
      report = await _analysisService.createReport(validatedIdea);
      record = pendingRecord.copyWith(
        reportJson: jsonEncode(report.toJson()),
        analysisMode: _analysisService.mode,
        status: 'completed',
      );
      await StartupAnalysisRecord.db.updateRow(session, record);
    } on StartupSenseError {
      await StartupAnalysisRecord.db.updateRow(
        session,
        pendingRecord.copyWith(
          analysisMode: _analysisService.mode,
          status: 'failed',
        ),
      );
      rethrow;
    }
    return AnalysisResponse(
      id: id,
      createdAt: record.createdAt,
      idea: validatedIdea,
      report: report,
      mode: record.analysisMode,
    );
  }

  Future<List<SavedAnalysisSummary>> listSavedAnalyses(
    Session session,
  ) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StartupSenseError(
        code: 'authentication_required',
        message: 'Sign in to view saved analyses.',
      );
    }
    final records = await StartupAnalysisRecord.db.find(
      session,
      where: (table) => table.authUserId.equals(authUserId),
      orderBy: (table) => table.createdAt.desc(),
      limit: 100,
    );
    return records
        .where((record) => record.id != null)
        .map(
          (record) => SavedAnalysisSummary(
            id: record.id!,
            startupName: record.startupName,
            industry: record.industry,
            createdAt: record.createdAt,
            status: record.status,
            isDemo: record.analysisMode == 'demo',
          ),
        )
        .toList(growable: false);
  }

  Future<AnalysisResponse> getAnalysis(Session session, int id) async {
    final authUserId = session.authenticated?.authUserId;
    if (authUserId == null) {
      throw StartupSenseError(
        code: 'authentication_required',
        message: 'Sign in to view a saved analysis.',
      );
    }
    final record = await StartupAnalysisRecord.db.findFirstRow(
      session,
      where: (table) =>
          table.id.equals(id) & table.authUserId.equals(authUserId),
    );
    if (record == null) {
      throw StartupSenseError(
        code: 'analysis_not_found',
        message: 'That saved analysis was not found.',
      );
    }
    if (record.status != 'completed' || record.id == null) {
      throw StartupSenseError(
        code: 'analysis_not_available',
        message: 'This analysis is not available yet.',
      );
    }

    try {
      final ideaJson = jsonDecode(record.ideaJson);
      final reportJson = jsonDecode(record.reportJson);
      if (ideaJson is! Map<String, dynamic> ||
          reportJson is! Map<String, dynamic>) {
        throw const FormatException('Saved report JSON must be an object.');
      }
      return AnalysisResponse(
        id: record.id!,
        createdAt: record.createdAt,
        idea: StartupIdeaRequest.fromJson(ideaJson),
        report: AnalysisReport.fromJson(reportJson),
        mode: record.analysisMode,
      );
    } on FormatException {
      throw StartupSenseError(
        code: 'saved_report_invalid',
        message:
            'The saved report could not be read. Please contact support if '
            'the problem continues.',
      );
    } on TypeError {
      throw StartupSenseError(
        code: 'saved_report_invalid',
        message:
            'The saved report has an invalid structure. Please contact '
            'support if the problem continues.',
      );
    }
  }

  StartupIdeaRequest _validateIdea(StartupIdeaRequest idea) {
    String text(String value, String label, int maxLength) {
      final normalized = value.trim();
      if (normalized.isEmpty || normalized.length > maxLength) {
        throw StartupSenseError(
          code: 'invalid_input',
          message:
              '$label is required and must be at most $maxLength '
              'characters.',
        );
      }
      return normalized;
    }

    final name = text(idea.startupName, 'Startup name', 80);
    final description = text(idea.description, 'Idea description', 5000);
    final industry = text(idea.industry, 'Industry', 80);
    final customer = text(idea.targetCustomer, 'Target customer', 300);
    final geography = text(idea.geography, 'Geography', 120);
    if (name.length < 2 ||
        description.length < 30 ||
        industry.length < 2 ||
        customer.length < 3 ||
        geography.length < 2) {
      throw StartupSenseError(
        code: 'invalid_input',
        message:
            'Add a startup name, a description of at least 30 characters, '
            'and specific industry, customer, and geography details.',
      );
    }
    if (!idea.estimatedBudget.isFinite ||
        idea.estimatedBudget < 0 ||
        idea.estimatedBudget > 100000000) {
      throw StartupSenseError(
        code: 'invalid_input',
        message: 'Starting budget must be between 0 and 100,000,000.',
      );
    }
    const stages = {'Idea', 'Research', 'MVP', 'Launched'};
    if (!stages.contains(idea.stage)) {
      throw StartupSenseError(
        code: 'invalid_input',
        message: 'Choose a valid startup stage.',
      );
    }
    return idea.copyWith(
      startupName: name,
      description: description,
      industry: industry,
      targetCustomer: customer,
      geography: geography,
    );
  }
}
