import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:startupsense_server/src/generated/protocol.dart';
import 'package:startupsense_server/src/startup_sense/startup_analysis_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given saved startup analyses',
    (sessionBuilder, endpoints) {
      const firstUserId = 'd4b57a71-7d2f-49d8-8fc1-0a10ed0f1a01';
      const secondUserId = '8dcf6a21-9520-46dc-9a1d-00857dc33402';
      final firstUser = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          firstUserId,
          {},
        ),
      );
      final secondUser = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          secondUserId,
          {},
        ),
      );

      setUp(() async {
        final session = sessionBuilder.build();
        await StartupAnalysisRecord.db.insertRow(
          session,
          _record(firstUserId, 'First founder idea'),
        );
        await StartupAnalysisRecord.db.insertRow(
          session,
          _record(secondUserId, 'Second founder idea'),
        );
      });

      test(
        'when a user lists reports then only their own report is returned',
        () async {
          final firstReports = await endpoints.startupAnalysis
              .listSavedAnalyses(firstUser);
          final secondReports = await endpoints.startupAnalysis
              .listSavedAnalyses(secondUser);

          expect(firstReports.map((report) => report.startupName), [
            'First founder idea',
          ]);
          expect(secondReports.map((report) => report.startupName), [
            'Second founder idea',
          ]);
        },
      );

      test(
        'when a user opens a report then saved typed data is restored',
        () async {
          final ownReport = (await endpoints.startupAnalysis.listSavedAnalyses(
            firstUser,
          )).single;
          final restored = await endpoints.startupAnalysis.getAnalysis(
            firstUser,
            ownReport.id,
          );

          expect(restored.idea.startupName, 'First founder idea');
          expect(restored.report.executiveSummary, 'A saved test summary.');
          expect(restored.mode, 'demo');
        },
      );

      test(
        'when a user requests another account report then it is not found',
        () async {
          final ownReport = (await endpoints.startupAnalysis.listSavedAnalyses(
            secondUser,
          )).single;

          await expectLater(
            endpoints.startupAnalysis.getAnalysis(firstUser, ownReport.id),
            throwsA(isA<StartupSenseError>()),
          );
        },
      );

      test(
        'when a request is unauthenticated then the endpoint rejects it',
        () async {
          final unauthenticated = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          );

          await expectLater(
            endpoints.startupAnalysis.listSavedAnalyses(unauthenticated),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
        },
      );

      test(
        'when an idea is incomplete then the server returns a validation error',
        () async {
          final invalidIdea = StartupIdeaRequest(
            startupName: 'Test',
            description: 'Too short',
            industry: 'Education',
            targetCustomer: 'Independent tutors',
            geography: 'Global',
            estimatedBudget: 1000,
            stage: 'Idea',
          );

          await expectLater(
            endpoints.startupAnalysis.analyzeIdea(firstUser, invalidIdea),
            throwsA(isA<StartupSenseError>()),
          );
        },
      );

      test(
        'when a valid idea is submitted then a demo report is saved',
        () async {
          final idea = StartupIdeaRequest(
            startupName: 'Fresh test concept',
            description:
                'A service that helps small teams organize customer feedback '
                'and prioritize useful product improvements.',
            industry: 'Software',
            targetCustomer: 'Small product teams',
            geography: 'United States',
            estimatedBudget: 5000,
            stage: 'Research',
          );
          final response = await endpoints.startupAnalysis.analyzeIdea(
            firstUser,
            idea,
          );
          final reports = await endpoints.startupAnalysis.listSavedAnalyses(
            firstUser,
          );
          final restored = await endpoints.startupAnalysis.getAnalysis(
            firstUser,
            response.id,
          );

          expect(response.mode, 'demo');
          expect(response.report.roadmap, hasLength(4));
          expect(
            reports.map((report) => report.startupName),
            contains(idea.startupName),
          );
          expect(
            restored.report.executiveSummary,
            response.report.executiveSummary,
          );
        },
        skip: StartupAnalysisService().mode == 'ai'
            ? 'Avoid external provider calls in integration tests.'
            : false,
      );
    },
  );
}

StartupAnalysisRecord _record(String userId, String startupName) {
  final idea = StartupIdeaRequest(
    startupName: startupName,
    description: 'A sufficiently detailed test startup idea description.',
    industry: 'Education',
    targetCustomer: 'Independent tutors',
    geography: 'Global',
    estimatedBudget: 1000,
    stage: 'Idea',
  );
  final report = AnalysisReport(
    executiveSummary: 'A saved test summary.',
    problem: 'Test problem.',
    solution: 'Test solution.',
    fitAssessment: 'Fit is unproven.',
    targetCustomers: [],
    marketOpportunity: 'Opportunity requires validation.',
    marketAssumptions: ['Assumption to validate.'],
    competitorHypotheses: [],
    strengths: ['Test strength.'],
    weaknesses: ['Test weakness.'],
    opportunities: ['Test opportunity.'],
    threats: ['Test threat.'],
    businessModel: 'Test model.',
    revenueStreams: ['Test revenue hypothesis.'],
    risks: [],
    experiments: [],
    mvpRecommendations: ['Test MVP recommendation.'],
    roadmap: [],
    evidenceDisclaimer: 'Test-only data; not researched.',
  );
  return StartupAnalysisRecord(
    authUserId: UuidValue.fromString(userId),
    startupName: startupName,
    industry: idea.industry,
    stage: idea.stage,
    ideaJson: jsonEncode(idea.toJson()),
    reportJson: jsonEncode(report.toJson()),
    analysisMode: 'demo',
    status: 'completed',
    createdAt: DateTime.utc(2026, 1, 1),
  );
}
