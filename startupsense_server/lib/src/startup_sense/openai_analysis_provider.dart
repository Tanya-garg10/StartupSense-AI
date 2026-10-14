import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../generated/protocol.dart';
import 'analysis_provider.dart';

class OpenAiAnalysisProvider implements AnalysisProvider {
  OpenAiAnalysisProvider(this._apiKey, {String? model})
    : _model = model?.trim().isNotEmpty == true ? model!.trim() : 'gpt-4o-mini';

  final String _apiKey;
  final String _model;

  @override
  String get mode => 'ai';

  @override
  Future<AnalysisReport> analyze(StartupIdeaRequest idea) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);

    try {
      final request = await client
          .postUrl(Uri.https('api.openai.com', '/v1/chat/completions'))
          .timeout(const Duration(seconds: 15));
      request.headers
        ..contentType = ContentType.json
        ..set(HttpHeaders.authorizationHeader, 'Bearer $_apiKey');
      request.write(
        jsonEncode({
          'model': _model,
          'temperature': 0.3,
          'max_tokens': 3000,
          'response_format': {'type': 'json_object'},
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a cautious startup discovery assistant. Return '
                  'only valid JSON matching the requested field names. Do '
                  'not invent named competitors, sources, citations, live '
                  'market statistics, customer counts, or revenue figures. '
                  'Describe competitor alternatives by category only. '
                  'Treat market and customer claims as hypotheses, label '
                  'uncertainty, and suggest experiments instead of making '
                  'viability guarantees. Use concise, useful content.',
            },
            {
              'role': 'user',
              'content':
                  '''
Analyze this startup idea. Return one JSON object with exactly these fields:
executiveSummary (string), problem (string), solution (string),
fitAssessment (string), targetCustomers (array of objects with label,
description, needs [strings]), marketOpportunity (string),
marketAssumptions (array of strings), competitorHypotheses (array of objects
with alternativeType, whatTheyOffer, differentiationOpportunity),
strengths, weaknesses, opportunities, threats (arrays of strings),
businessModel (string), revenueStreams (array of strings), risks (array of
objects with title, description, likelihood, mitigation), experiments (array
of objects with title, hypothesis, method, successSignal, estimatedDays
integer), mvpRecommendations (array of strings), roadmap (exactly four
objects with week integer, theme, tasks [strings]), evidenceDisclaimer
(string). Include realistic assumptions, no unsupported numbers, and no
real competitor names. Treat all research as preliminary hypotheses.

Idea: ${jsonEncode(idea.toJson())}
''',
            },
          ],
        }),
      );

      final response = await request.close().timeout(
        const Duration(seconds: 45),
      );
      final responseBody = await response
          .transform(utf8.decoder)
          .join()
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == HttpStatus.tooManyRequests) {
        throw StartupSenseError(
          code: 'ai_rate_limited',
          message:
              'The analysis provider is rate limiting requests. Please try '
              'again shortly.',
        );
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StartupSenseError(
          code: 'ai_provider_unavailable',
          message:
              'The analysis provider returned an error. Please try again '
              'later.',
        );
      }

      final decodedResponse = jsonDecode(responseBody);
      if (decodedResponse is! Map<String, dynamic>) {
        throw StartupSenseError(
          code: 'invalid_ai_response',
          message: 'The analysis provider returned an invalid response.',
        );
      }
      final choices = decodedResponse['choices'];
      if (choices is! List || choices.isEmpty) {
        throw StartupSenseError(
          code: 'invalid_ai_response',
          message: 'The analysis provider returned no report content.',
        );
      }
      final firstChoice = choices.first;
      if (firstChoice is! Map<String, dynamic>) {
        throw StartupSenseError(
          code: 'invalid_ai_response',
          message: 'The analysis provider returned an invalid report.',
        );
      }
      final message = firstChoice['message'];
      if (message is! Map<String, dynamic> || message['content'] is! String) {
        throw StartupSenseError(
          code: 'invalid_ai_response',
          message: 'The analysis provider returned an invalid report.',
        );
      }

      final reportJson = jsonDecode(message['content'] as String);
      if (reportJson is! Map<String, dynamic>) {
        throw StartupSenseError(
          code: 'invalid_ai_response',
          message: 'The analysis provider returned an invalid report.',
        );
      }
      final report = AnalysisReport.fromJson(reportJson);
      _validateReport(report);
      return report.copyWith(evidenceDisclaimer: evidenceDisclaimer);
    } on TimeoutException {
      throw StartupSenseError(
        code: 'ai_timeout',
        message: 'Analysis timed out. Please try again.',
      );
    } on SocketException {
      throw StartupSenseError(
        code: 'ai_connection_failed',
        message:
            'Could not reach the analysis provider. Check the server '
            'connection and try again.',
      );
    } on HttpException {
      throw StartupSenseError(
        code: 'ai_connection_failed',
        message: 'The analysis provider connection failed. Please try again.',
      );
    } on FormatException {
      throw StartupSenseError(
        code: 'invalid_ai_response',
        message: 'The analysis provider returned malformed JSON.',
      );
    } on TypeError {
      throw StartupSenseError(
        code: 'invalid_ai_response',
        message:
            'The analysis provider report did not match the required '
            'structure.',
      );
    } finally {
      client.close(force: true);
    }
  }

  void _validateReport(AnalysisReport report) {
    if (report.executiveSummary.trim().isEmpty ||
        report.problem.trim().isEmpty ||
        report.solution.trim().isEmpty ||
        report.fitAssessment.trim().isEmpty ||
        report.marketOpportunity.trim().isEmpty ||
        report.businessModel.trim().isEmpty ||
        report.targetCustomers.isEmpty ||
        report.competitorHypotheses.isEmpty ||
        report.experiments.isEmpty ||
        report.roadmap.length != 4) {
      throw StartupSenseError(
        code: 'invalid_ai_response',
        message:
            'The analysis provider returned an incomplete report. Please '
            'retry the analysis.',
      );
    }
  }
}
