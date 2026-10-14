import '../generated/protocol.dart';

abstract interface class AnalysisProvider {
  String get mode;

  Future<AnalysisReport> analyze(StartupIdeaRequest idea);
}

const evidenceDisclaimer =
    'This report is decision support, not a guarantee of success. Market, '
    'competitor, and customer statements are preliminary generated '
    'hypotheses unless independently verified. No live market research or '
    'external sources were consulted.';
