import 'package:startupsense_client/startupsense_client.dart';

import '../client.dart';

class StartupSenseRepository {
  Future<AnalysisResponse> analyzeIdea(StartupIdeaRequest idea) {
    return client.startupAnalysis.analyzeIdea(idea);
  }

  Future<List<SavedAnalysisSummary>> listSavedAnalyses() {
    return client.startupAnalysis.listSavedAnalyses();
  }

  Future<AnalysisResponse> getAnalysis(int id) {
    return client.startupAnalysis.getAnalysis(id);
  }
}
