import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:startupsense_client/startupsense_client.dart';

class ReportExportService {
  Future<void> printReport(AnalysisResponse analysis) async {
    final report = analysis.report;
    final document = pw.Document();
    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(42),
        build: (context) => [
          pw.Text(
            'STARTUPSENSE AI  ·  IDEA VALIDATION',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#7356D8'),
            ),
          ),
          pw.SizedBox(height: 14),
          pw.Text(
            analysis.idea.startupName,
            style: pw.TextStyle(
              fontSize: 27,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#17172F'),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            '${analysis.idea.industry}  ·  ${analysis.idea.geography}  ·  '
            '${_date(analysis.createdAt)}',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            analysis.mode == 'demo'
                ? 'DEMO MODE — deterministic sample analysis, not AI-generated'
                : 'AI-generated decision support — validate independently',
            style: pw.TextStyle(
              fontSize: 9,
              fontWeight: pw.FontWeight.bold,
              color: analysis.mode == 'demo'
                  ? PdfColor.fromHex('#87510E')
                  : PdfColor.fromHex('#2C8A79'),
            ),
          ),
          pw.SizedBox(height: 22),
          _section('Executive summary', report.executiveSummary),
          _section('Problem', report.problem),
          _section('Proposed solution', report.solution),
          _section('Problem-solution fit', report.fitAssessment),
          _section(
            'Target customers',
            report.targetCustomers
                .map(
                  (persona) =>
                      '${persona.label}: ${persona.description}\n'
                      'Needs: ${persona.needs.join('; ')}',
                )
                .join('\n\n'),
          ),
          _section('Market opportunity', report.marketOpportunity),
          _section(
            'Market assumptions',
            report.marketAssumptions.map((item) => '• $item').join('\n'),
          ),
          _section(
            'Competitor alternatives (hypotheses)',
            report.competitorHypotheses
                .map(
                  (alternative) =>
                      '${alternative.alternativeType}: '
                      '${alternative.whatTheyOffer}\n'
                      'Opportunity: '
                      '${alternative.differentiationOpportunity}',
                )
                .join('\n\n'),
          ),
          _section(
            'Strengths',
            report.strengths.map((item) => '• $item').join('\n'),
          ),
          _section(
            'Weaknesses',
            report.weaknesses.map((item) => '• $item').join('\n'),
          ),
          _section(
            'Opportunities',
            report.opportunities.map((item) => '• $item').join('\n'),
          ),
          _section(
            'Threats',
            report.threats.map((item) => '• $item').join('\n'),
          ),
          _section('Business model', report.businessModel),
          _section(
            'Revenue options',
            report.revenueStreams.map((item) => '• $item').join('\n'),
          ),
          _section(
            'Key risks',
            report.risks
                .map(
                  (risk) =>
                      '${risk.title} (${risk.likelihood}): '
                      '${risk.description}\nMitigation: ${risk.mitigation}',
                )
                .join('\n\n'),
          ),
          _section(
            'Customer validation experiments',
            report.experiments
                .map(
                  (experiment) =>
                      '${experiment.title} (${experiment.estimatedDays} days)\n'
                      'Hypothesis: ${experiment.hypothesis}\n'
                      'Method: ${experiment.method}\n'
                      'Success signal: ${experiment.successSignal}',
                )
                .join('\n\n'),
          ),
          _section(
            'MVP recommendations',
            report.mvpRecommendations.map((item) => '• $item').join('\n'),
          ),
          _section(
            '30-day roadmap',
            report.roadmap
                .map(
                  (week) =>
                      'Week ${week.week}: ${week.theme}\n'
                      '${week.tasks.map((task) => '• $task').join('\n')}',
                )
                .join('\n\n'),
          ),
          pw.SizedBox(height: 12),
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('#F0ECFF'),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Text(
              report.evidenceDisclaimer,
              style: const pw.TextStyle(fontSize: 9, lineSpacing: 2),
            ),
          ),
        ],
      ),
    );
    await Printing.layoutPdf(
      name: '${_fileName(analysis.idea.startupName)}-startup-report.pdf',
      onLayout: (_) => document.save(),
    );
  }

  pw.Widget _section(String title, String content) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 15),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 12,
              fontWeight: pw.FontWeight.bold,
              color: PdfColor.fromHex('#17172F'),
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            content,
            style: const pw.TextStyle(fontSize: 10, lineSpacing: 2),
          ),
        ],
      ),
    );
  }

  String _date(DateTime value) =>
      '${value.toLocal().year}-${value.toLocal().month.toString().padLeft(2, '0')}-'
      '${value.toLocal().day.toString().padLeft(2, '0')}';

  String _fileName(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}
