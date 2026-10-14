import 'package:flutter/material.dart';
import 'package:startupsense_client/startupsense_client.dart';

import '../../data/startup_sense_repository.dart';
import '../../theme.dart';
import '../../widgets/sense_widgets.dart';

class SavedReportsScreen extends StatefulWidget {
  const SavedReportsScreen({
    required this.onAnalyze,
    required this.onOpenReport,
    super.key,
  });

  final VoidCallback onAnalyze;
  final ValueChanged<int> onOpenReport;

  @override
  State<SavedReportsScreen> createState() => _SavedReportsScreenState();
}

class _SavedReportsScreenState extends State<SavedReportsScreen> {
  final _repository = StartupSenseRepository();
  late Future<List<SavedAnalysisSummary>> _reports;

  @override
  void initState() {
    super.initState();
    _reports = _repository.listSavedAnalyses();
  }

  void _refresh() {
    setState(() => _reports = _repository.listSavedAnalyses());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 42),
      children: [
        ContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EyebrowLabel('YOUR WORKSPACE'),
              const SizedBox(height: 10),
              Text(
                'Saved reports',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Reports are fetched from your account. Demo analyses are '
                'labelled separately from provider-generated reports.',
                style: TextStyle(color: StartupSenseColors.muted, height: 1.5),
              ),
              const SizedBox(height: 24),
              FutureBuilder<List<SavedAnalysisSummary>>(
                future: _reports,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Card(
                      child: SizedBox(
                        height: 210,
                        child: LoadingPanel(label: 'Refreshing saved reports…'),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ErrorNotice(
                              message:
                                  'Saved reports could not be loaded from the '
                                  'server. Check your connection and retry.',
                            ),
                            const SizedBox(height: 14),
                            OutlinedButton.icon(
                              onPressed: _refresh,
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Try again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  final reports = snapshot.data ?? const [];
                  if (reports.isEmpty) {
                    return EmptyPanel(
                      title: 'No saved reports yet',
                      description:
                          'Your analyses will live here, ready to revisit '
                          'when your idea evolves.',
                      action: 'Analyze an idea',
                      onAction: widget.onAnalyze,
                    );
                  }
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${reports.length} saved '
                              '${reports.length == 1 ? 'analysis' : 'analyses'}',
                              style: const TextStyle(
                                color: StartupSenseColors.muted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Refresh saved reports',
                            onPressed: _refresh,
                            icon: const Icon(Icons.refresh_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      for (final report in reports)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _SavedReportCard(
                            report: report,
                            onTap: report.status == 'completed'
                                ? () => widget.onOpenReport(report.id)
                                : null,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SavedReportCard extends StatelessWidget {
  const _SavedReportCard({required this.report, required this.onTap});

  final SavedAnalysisSummary report;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isCompleted = report.status == 'completed';
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: StartupSenseColors.lavender,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: StartupSenseColors.violet,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.startupName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${report.industry}  ·  ${_date(report.createdAt)}',
                      style: const TextStyle(
                        color: StartupSenseColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InlinePill(
                label: report.isDemo ? 'DEMO' : 'AI',
                color: report.isDemo
                    ? const Color(0xFFFFF1DC)
                    : StartupSenseColors.paleTeal,
                foregroundColor: report.isDemo
                    ? const Color(0xFF87510E)
                    : StartupSenseColors.teal,
              ),
              const SizedBox(width: 8),
              InlinePill(
                label: report.status.toUpperCase(),
                color: isCompleted
                    ? StartupSenseColors.paleTeal
                    : const Color(0xFFFFF1DC),
                foregroundColor: isCompleted
                    ? StartupSenseColors.teal
                    : const Color(0xFF87510E),
              ),
              const SizedBox(width: 6),
              Icon(
                isCompleted ? Icons.chevron_right_rounded : Icons.schedule,
                color: StartupSenseColors.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _date(DateTime value) =>
    '${value.toLocal().year}-${value.toLocal().month.toString().padLeft(2, '0')}-'
    '${value.toLocal().day.toString().padLeft(2, '0')}';
