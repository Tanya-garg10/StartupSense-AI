import 'package:startupsense_server/src/generated/protocol.dart';
import 'package:startupsense_server/src/startup_sense/startup_analysis_service.dart';
import 'package:test/test.dart';

void main() {
  group('StartupAnalysisService demo mode', () {
    final service = StartupAnalysisService(apiKey: '');
    final idea = StartupIdeaRequest(
      startupName: 'Fieldnote',
      description:
          'A planning tool that helps independent growers coordinate weekly '
          'harvests and communicate availability with local buyers.',
      industry: 'Agriculture',
      targetCustomer: 'Independent urban growers',
      geography: 'Bengaluru, India',
      estimatedBudget: 25000,
      stage: 'Research',
    );

    test(
      'uses deterministic, clearly caveated demo analysis without a key',
      () async {
        expect(service.mode, 'demo');
        final report = await service.createReport(idea);

        expect(report.executiveSummary, contains('Fieldnote'));
        expect(report.executiveSummary, contains('Bengaluru, India'));
        expect(report.targetCustomers, isNotEmpty);
        expect(report.competitorHypotheses, isNotEmpty);
        expect(report.experiments, isNotEmpty);
        expect(report.roadmap, hasLength(4));
        expect(
          report.evidenceDisclaimer,
          contains('preliminary generated hypotheses'),
        );
        expect(report.evidenceDisclaimer, contains('No live market research'));
      },
    );
  });
}
