import 'dart:io';

import '../generated/protocol.dart';
import 'analysis_provider.dart';
import 'demo_analysis_provider.dart';
import 'featherless_analysis_provider.dart';

class StartupAnalysisService {
  StartupAnalysisService({
    String? featherlessApiKey,
    String? featherlessModel,
    AnalysisProvider? provider,
  }) : _provider =
           provider ??
           _createProvider(
             featherlessApiKey ?? Platform.environment['FEATHERLESS_API_KEY'],
             featherlessModel ?? Platform.environment['FEATHERLESS_MODEL'],
           );

  final AnalysisProvider _provider;

  String get mode => _provider.mode;

  Future<AnalysisReport> createReport(StartupIdeaRequest idea) {
    return _provider.analyze(idea);
  }

  static AnalysisProvider _createProvider(
    String? featherlessApiKey,
    String? featherlessModel,
  ) {
    if (featherlessApiKey?.trim().isNotEmpty == true) {
      final selectedModel = featherlessModel?.trim();
      return FeatherlessAnalysisProvider(
        featherlessApiKey!.trim(),
        model: selectedModel?.isNotEmpty == true
            ? selectedModel
            : 'Qwen/Qwen3-Next-80B-A3B-Instruct',
      );
    }
    return DemoAnalysisProvider();
  }
}
