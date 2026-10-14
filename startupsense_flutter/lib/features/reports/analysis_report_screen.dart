import 'package:flutter/material.dart';
import 'package:startupsense_client/startupsense_client.dart';

import '../../services/report_export_service.dart';
import '../../theme.dart';
import '../../widgets/sense_widgets.dart';

class AnalysisReportScreen extends StatefulWidget {
  const AnalysisReportScreen({
    required this.analysis,
    required this.onBack,
    super.key,
  });

  final AnalysisResponse analysis;
  final VoidCallback onBack;

  @override
  State<AnalysisReportScreen> createState() => _AnalysisReportScreenState();
}

class _AnalysisReportScreenState extends State<AnalysisReportScreen> {
  bool _isExporting = false;

  Future<void> _export() async {
    if (_isExporting) return;
    setState(() => _isExporting = true);
    try {
      await ReportExportService().printReport(widget.analysis);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Report sent to print or PDF export.')),
        );
      }
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not export this report. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final analysis = widget.analysis;
    final report = analysis.report;
    final demo = analysis.mode == 'demo';
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 42),
      children: [
        ContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Back to workspace'),
              ),
              const SizedBox(height: 8),
              Card(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFFFFF), Color(0xFFF1EEFF)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(child: EyebrowLabel('IDEA ANALYSIS')),
                          InlinePill(
                            label: demo ? 'DEMO MODE' : 'AI ANALYSIS',
                            color: demo
                                ? const Color(0xFFFFF1DC)
                                : StartupSenseColors.paleTeal,
                            foregroundColor: demo
                                ? const Color(0xFF87510E)
                                : StartupSenseColors.teal,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        analysis.idea.startupName,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '${analysis.idea.industry}  ·  '
                        '${analysis.idea.geography}  ·  '
                        '${_date(analysis.createdAt)}',
                        style: const TextStyle(color: StartupSenseColors.muted),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        report.executiveSummary,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              height: 1.55,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 18),
                      FilledButton.tonalIcon(
                        onPressed: _isExporting ? null : _export,
                        icon: _isExporting
                            ? const SizedBox.square(
                                dimension: 17,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.print_outlined),
                        label: Text(
                          _isExporting
                              ? 'Preparing report…'
                              : 'Print / export PDF',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _EvidenceBanner(demo: demo, message: report.evidenceDisclaimer),
              const SizedBox(height: 24),
              _ReportSection(
                eyebrow: '01 · THE OPPORTUNITY',
                title: 'Problem & solution',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Subsection(label: 'Problem', body: report.problem),
                    const SizedBox(height: 16),
                    _Subsection(
                      label: 'Proposed solution',
                      body: report.solution,
                    ),
                    const SizedBox(height: 16),
                    _Subsection(
                      label: 'Problem-solution fit',
                      body: report.fitAssessment,
                    ),
                  ],
                ),
              ),
              _ReportSection(
                eyebrow: '02 · WHO IT SERVES',
                title: 'Target customers',
                child: Column(
                  children: [
                    for (final persona in report.targetCustomers)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _PersonaCard(persona: persona),
                      ),
                  ],
                ),
              ),
              _ReportSection(
                eyebrow: '03 · WHAT IS KNOWN',
                title: 'Market opportunity & assumptions',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.marketOpportunity,
                      style: const TextStyle(height: 1.6),
                    ),
                    const SizedBox(height: 16),
                    const _LabelChip(
                      icon: Icons.help_outline_rounded,
                      label: 'ASSUMPTIONS TO VERIFY',
                    ),
                    const SizedBox(height: 12),
                    BulletList(items: report.marketAssumptions),
                  ],
                ),
              ),
              _ReportSection(
                eyebrow: '04 · ALTERNATIVES',
                title: 'Competitor landscape',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Preliminary categories of alternatives—not live '
                      'competitor research.',
                      style: TextStyle(color: StartupSenseColors.muted),
                    ),
                    const SizedBox(height: 14),
                    for (final alternative in report.competitorHypotheses)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _CompetitorCard(alternative: alternative),
                      ),
                  ],
                ),
              ),
              _ReportSection(
                eyebrow: '05 · INTERNAL VIEW',
                title: 'SWOT analysis',
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final twoColumns = constraints.maxWidth > 560;
                    final items = [
                      _SwotCard(
                        title: 'Strengths',
                        items: report.strengths,
                        color: StartupSenseColors.paleTeal,
                        icon: Icons.arrow_upward_rounded,
                      ),
                      _SwotCard(
                        title: 'Weaknesses',
                        items: report.weaknesses,
                        color: const Color(0xFFFFF1DC),
                        icon: Icons.priority_high_rounded,
                      ),
                      _SwotCard(
                        title: 'Opportunities',
                        items: report.opportunities,
                        color: StartupSenseColors.lavender,
                        icon: Icons.north_east_rounded,
                      ),
                      _SwotCard(
                        title: 'Threats',
                        items: report.threats,
                        color: const Color(0xFFFFEEF0),
                        icon: Icons.shield_outlined,
                      ),
                    ];
                    if (!twoColumns) {
                      return Column(
                        children: [
                          for (final item in items)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: item,
                            ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        for (var i = 0; i < items.length; i += 2)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: items[i]),
                                const SizedBox(width: 10),
                                Expanded(child: items[i + 1]),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              _ReportSection(
                eyebrow: '06 · HOW IT COULD EARN',
                title: 'Business & revenue model',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.businessModel,
                      style: const TextStyle(height: 1.6),
                    ),
                    const SizedBox(height: 14),
                    BulletList(items: report.revenueStreams),
                  ],
                ),
              ),
              _ReportSection(
                eyebrow: '07 · WHAT COULD GO WRONG',
                title: 'Key risks',
                child: Column(
                  children: [
                    for (final risk in report.risks)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _RiskCard(risk: risk),
                      ),
                  ],
                ),
              ),
              _ReportSection(
                eyebrow: '08 · LEARN BEFORE BUILDING',
                title: 'Customer validation experiments',
                child: Column(
                  children: [
                    for (
                      var index = 0;
                      index < report.experiments.length;
                      index++
                    )
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ExperimentCard(
                          experiment: report.experiments[index],
                          number: index + 1,
                        ),
                      ),
                  ],
                ),
              ),
              _ReportSection(
                eyebrow: '09 · FIRST BUILD',
                title: 'MVP recommendations',
                child: BulletList(items: report.mvpRecommendations),
              ),
              _ReportSection(
                eyebrow: '10 · FIRST MONTH',
                title: '30-day execution roadmap',
                child: Column(
                  children: [
                    for (final week in report.roadmap)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: _RoadmapCard(week: week),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const _DecisionFooter(),
            ],
          ),
        ),
      ],
    );
  }
}

class _EvidenceBanner extends StatelessWidget {
  const _EvidenceBanner({required this.demo, required this.message});

  final bool demo;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: demo ? const Color(0xFFFFF7EA) : StartupSenseColors.paleTeal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: demo ? const Color(0xFFF0D8B5) : const Color(0xFFC5E4DB),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            demo ? Icons.science_outlined : Icons.verified_user_outlined,
            color: demo ? const Color(0xFF87510E) : StartupSenseColors.teal,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  demo
                      ? 'DEMO ANALYSIS · simulated, not AI-generated'
                      : 'AI-GENERATED SUGGESTIONS · verify before acting',
                  style: TextStyle(
                    color: demo
                        ? const Color(0xFF87510E)
                        : StartupSenseColors.teal,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(message, style: const TextStyle(height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportSection extends StatelessWidget {
  const _ReportSection({
    required this.eyebrow,
    required this.title,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 13),
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EyebrowLabel(eyebrow),
            const SizedBox(height: 6),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _Subsection extends StatelessWidget {
  const _Subsection({required this.label, required this.body});

  final String label;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(body, style: const TextStyle(height: 1.6)),
      ],
    );
  }
}

class _PersonaCard extends StatelessWidget {
  const _PersonaCard({required this.persona});

  final CustomerPersona persona;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: StartupSenseColors.canvas,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            persona.label,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          Text(persona.description, style: const TextStyle(height: 1.5)),
          const SizedBox(height: 11),
          const _LabelChip(
            icon: Icons.favorite_border_rounded,
            label: 'LIKELY NEEDS',
          ),
          const SizedBox(height: 9),
          BulletList(items: persona.needs),
        ],
      ),
    );
  }
}

class _CompetitorCard extends StatelessWidget {
  const _CompetitorCard({required this.alternative});

  final CompetitorHypothesis alternative;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: StartupSenseColors.canvas,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InlinePill(label: alternative.alternativeType),
          const SizedBox(height: 10),
          Text(alternative.whatTheyOffer, style: const TextStyle(height: 1.5)),
          const SizedBox(height: 10),
          Text(
            'Differentiation to test',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: StartupSenseColors.violet,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            alternative.differentiationOpportunity,
            style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _SwotCard extends StatelessWidget {
  const _SwotCard({
    required this.title,
    required this.items,
    required this.color,
    required this.icon,
  });

  final String title;
  final List<String> items;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 17),
              const SizedBox(width: 7),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 11),
          BulletList(items: items),
        ],
      ),
    );
  }
}

class _RiskCard extends StatelessWidget {
  const _RiskCard({required this.risk});

  final RiskItem risk;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  risk.title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              InlinePill(
                label: risk.likelihood.toUpperCase(),
                color: Colors.white,
                foregroundColor: StartupSenseColors.muted,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(risk.description, style: const TextStyle(height: 1.5)),
          const SizedBox(height: 10),
          Text(
            'Mitigation: ${risk.mitigation}',
            style: const TextStyle(
              color: StartupSenseColors.teal,
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperimentCard extends StatelessWidget {
  const _ExperimentCard({required this.experiment, required this.number});

  final ValidationExperiment experiment;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: StartupSenseColors.canvas,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: StartupSenseColors.ink,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  experiment.title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              InlinePill(label: '${experiment.estimatedDays} DAYS'),
            ],
          ),
          const SizedBox(height: 12),
          _Subsection(label: 'Hypothesis', body: experiment.hypothesis),
          const SizedBox(height: 10),
          _Subsection(label: 'Method', body: experiment.method),
          const SizedBox(height: 10),
          _Subsection(label: 'Success signal', body: experiment.successSignal),
        ],
      ),
    );
  }
}

class _RoadmapCard extends StatelessWidget {
  const _RoadmapCard({required this.week});

  final RoadmapWeek week;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: StartupSenseColors.canvas,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InlinePill(label: 'WEEK ${week.week}'),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  week.theme,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BulletList(items: week.tasks),
        ],
      ),
    );
  }
}

class _LabelChip extends StatelessWidget {
  const _LabelChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: StartupSenseColors.violet),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: StartupSenseColors.violet,
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.7,
          ),
        ),
      ],
    );
  }
}

class _DecisionFooter extends StatelessWidget {
  const _DecisionFooter();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: StartupSenseColors.violet),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Use this report to decide what to test—not whether a startup '
              'is guaranteed to succeed. Talk to customers and verify '
              'important claims independently.',
              style: TextStyle(color: StartupSenseColors.muted, height: 1.55),
            ),
          ),
        ],
      ),
    );
  }
}

String _date(DateTime value) =>
    '${value.toLocal().year}-${value.toLocal().month.toString().padLeft(2, '0')}-'
    '${value.toLocal().day.toString().padLeft(2, '0')}';
