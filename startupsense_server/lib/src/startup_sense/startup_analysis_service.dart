import 'dart:io';

import '../generated/protocol.dart';
import 'analysis_provider.dart';
import 'demo_analysis_provider.dart';
import 'openai_analysis_provider.dart';

class StartupAnalysisService {
  StartupAnalysisService({
    String? apiKey,
    String? model,
    AnalysisProvider? provider,
  }) : _provider =
           provider ??
           _createProvider(
             apiKey ?? Platform.environment['OPENAI_API_KEY'],
             model ?? Platform.environment['OPENAI_MODEL'],
           );

  final AnalysisProvider _provider;

  String get mode => _provider.mode;

  Future<AnalysisReport> createReport(StartupIdeaRequest idea) {
    return _provider.analyze(idea);
  }

  static AnalysisProvider _createProvider(String? apiKey, String? model) {
    if (apiKey?.trim().isNotEmpty == true) {
      return OpenAiAnalysisProvider(apiKey!.trim(), model: model);
    }
    return DemoAnalysisProvider();
  }
}
