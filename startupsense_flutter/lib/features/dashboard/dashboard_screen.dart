import 'package:flutter/material.dart';
import 'package:startupsense_client/startupsense_client.dart';

import '../../data/startup_sense_repository.dart';
import '../../theme.dart';
import '../../widgets/sense_widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    required this.onAnalyze,
    required this.onOpenReport,
    required this.onOpenHistory,
    super.key,
  });

  final VoidCallback onAnalyze;
  final ValueChanged<int> onOpenReport;
  final VoidCallback onOpenHistory;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 42),
      children: [
        ContentWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final narrow = constraints.maxWidth < 690;
                  return Container(
                    padding: EdgeInsets.all(narrow ? 24 : 34),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF191832),
                          Color(0xFF292248),
                          Color(0xFF3B2E68),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -5,
                          top: -16,
                          child: Icon(
                            Icons.auto_graph_rounded,
                            size: narrow ? 90 : 138,
                            color: Colors.white.withValues(alpha: 0.07),
                          ),
                        ),
                        if (narrow)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _HeroCopy(
                                onAnalyze: widget.onAnalyze,
                                narrow: true,
                              ),
                              const SizedBox(height: 18),
                              const _DecisionNote(),
                            ],
                          )
                        else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 7,
                                child: _HeroCopy(
                                  onAnalyze: widget.onAnalyze,
                                  narrow: false,
                                ),
                              ),
                              const SizedBox(width: 26),
                              const Expanded(flex: 4, child: _DecisionNote()),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              const SectionTitle(
                title: 'Your progress',
                subtitle: 'A snapshot of your saved work, not estimates.',
              ),
              const SizedBox(height: 14),
              FutureBuilder<List<SavedAnalysisSummary>>(
                future: _reports,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _LoadError(
                      message:
                          'Your saved reports could not be loaded. Try again '
                          'in a moment.',
                      onRetry: _refresh,
                    );
                  }
                  if (!snapshot.hasData) return const _StatsSkeleton();
                  final reports = snapshot.data!;
                  final industries = reports
                      .map((report) => report.industry.toLowerCase())
                      .toSet()
                      .length;
                  final demoCount = reports
                      .where((report) => report.isDemo)
                      .length;
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth >= 690 ? 3 : 1;
                      final cards = [
                        _StatCard(
                          label: 'Saved analyses',
                          value: '${reports.length}',
                          detail: 'reports in your account',
                          icon: Icons.description_outlined,
                          accent: StartupSenseColors.violet,
                        ),
                        _StatCard(
                          label: 'Industries explored',
                          value: '$industries',
                          detail: 'represented in saved reports',
                          icon: Icons.grid_view_rounded,
                          accent: StartupSenseColors.teal,
                        ),
                        _StatCard(
                          label: 'Demo reports',
                          value: '$demoCount',
                          detail: 'clearly labelled simulations',
                          icon: Icons.science_outlined,
                          accent: const Color(0xFFB16A28),
                        ),
                      ];
                      if (columns == 1) {
                        return Column(
                          children: [
                            for (var index = 0; index < cards.length; index++)
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: index == cards.length - 1 ? 0 : 10,
                                ),
                                child: cards[index],
                              ),
                          ],
                        );
                      }
                      return Row(
                        children: [
                          for (var index = 0; index < cards.length; index++)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: index == cards.length - 1 ? 0 : 12,
                                ),
                                child: cards[index],
                              ),
                            ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 28),
              SectionTitle(
                title: 'Recent analyses',
                subtitle: 'Pick up where your last idea left off.',
                trailing: TextButton(
                  onPressed: widget.onOpenHistory,
                  child: const Text('View history'),
                ),
              ),
              const SizedBox(height: 14),
              FutureBuilder<List<SavedAnalysisSummary>>(
                future: _reports,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _LoadError(
                      message:
                          'Recent analyses are unavailable until the server '
                          'responds.',
                      onRetry: _refresh,
                    );
                  }
                  if (!snapshot.hasData) {
                    return const _RecentSkeleton();
                  }
                  final reports = snapshot.data!;
                  if (reports.isEmpty) {
                    return EmptyPanel(
                      title: 'Your first idea starts here',
                      description:
                          'Your dashboard will show real saved reports once '
                          'you run your first analysis.',
                      action: 'Analyze an idea',
                      onAction: widget.onAnalyze,
                      icon: Icons.lightbulb_outline_rounded,
                    );
                  }
                  return Card(
                    child: Column(
                      children: [
                        for (
                          var index = 0;
                          index < reports.length && index < 4;
                          index++
                        )
                          _RecentReportTile(
                            report: reports[index],
                            isLast:
                                index == reports.length - 1 ||
                                index == 3 ||
                                reports.length == 1,
                            onTap: () => widget.onOpenReport(reports[index].id),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              const SectionTitle(
                title: 'From idea to evidence',
                subtitle: 'A practical workspace for the earliest hard calls.',
              ),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cards = const [
                    _FeatureCard(
                      icon: Icons.manage_search_rounded,
                      number: '01',
                      title: 'Pressure-test the problem',
                      description:
                          'Separate what you know from what needs a real '
                          'customer conversation.',
                    ),
                    _FeatureCard(
                      icon: Icons.compare_arrows_rounded,
                      number: '02',
                      title: 'Map the alternatives',
                      description:
                          'Explore categories of competing workarounds '
                          'without pretending to have live research.',
                    ),
                    _FeatureCard(
                      icon: Icons.route_rounded,
                      number: '03',
                      title: 'Choose a next step',
                      description:
                          'Get practical validation experiments, an MVP '
                          'starting point, and a 30-day roadmap.',
                    ),
                  ];
                  if (constraints.maxWidth < 690) {
                    return Column(
                      children: [
                        for (final card in cards)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: card,
                          ),
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < cards.length; i++)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: i == cards.length - 1 ? 0 : 12,
                            ),
                            child: cards[i],
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const _FooterDisclaimer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _DecisionNote extends StatelessWidget {
  const _DecisionNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.track_changes_rounded, color: StartupSenseColors.lime),
          SizedBox(height: 12),
          Text(
            'Make the next decision smaller.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'No success scores. No made-up market sizing. Just assumptions '
            'to test and a plan for learning.',
            style: TextStyle(color: Color(0xFFD2D0E0), height: 1.55),
          ),
        ],
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.onAnalyze, required this.narrow});

  final VoidCallback onAnalyze;
  final bool narrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InlinePill(
          label: 'YOUR FOUNDER WORKSPACE',
          color: Color(0xFF393252),
          foregroundColor: StartupSenseColors.lime,
        ),
        const SizedBox(height: 20),
        Text(
          'Validate Your Idea.\nBuild With Confidence.',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white,
            fontSize: narrow ? 34 : 43,
            height: 1.08,
          ),
        ),
        const SizedBox(height: 13),
        const Text(
          'Turn a hunch into a sharper plan: understand the unknowns, talk to '
          'real customers, and build only what you learn.',
          style: TextStyle(color: Color(0xFFD2D0E0), height: 1.6),
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: onAnalyze,
          style: FilledButton.styleFrom(
            backgroundColor: StartupSenseColors.lime,
            foregroundColor: StartupSenseColors.ink,
          ),
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Analyze My Idea'),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.detail,
    required this.icon,
    required this.accent,
  });

  final String label;
  final String value;
  final String detail;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(icon, color: accent, size: 21),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: StartupSenseColors.muted,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    detail,
                    style: const TextStyle(
                      color: StartupSenseColors.muted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentReportTile extends StatelessWidget {
  const _RecentReportTile({
    required this.report,
    required this.isLast,
    required this.onTap,
  });

  final SavedAnalysisSummary report;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: StartupSenseColors.lavender,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: StartupSenseColors.violet,
            ),
          ),
          title: Text(
            report.startupName,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            '${report.industry}  ·  ${_shortDate(report.createdAt)}',
            style: const TextStyle(color: StartupSenseColors.muted),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              const Icon(
                Icons.chevron_right_rounded,
                color: StartupSenseColors.muted,
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, indent: 70, endIndent: 16),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.number,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String number;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: StartupSenseColors.violet),
                const Spacer(),
                Text(
                  number,
                  style: const TextStyle(
                    color: StartupSenseColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
            const SizedBox(height: 7),
            Text(
              description,
              style: const TextStyle(
                color: StartupSenseColors.muted,
                height: 1.5,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterDisclaimer extends StatelessWidget {
  const _FooterDisclaimer();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.info_outline_rounded,
          size: 18,
          color: StartupSenseColors.muted,
        ),
        const SizedBox(width: 9),
        const Expanded(
          child: Text(
            'StartupSense offers decision support, not a guarantee of '
            'success. Research and competitor information is preliminary '
            'unless independently verified.',
            style: TextStyle(
              color: StartupSenseColors.muted,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsSkeleton extends StatelessWidget {
  const _StatsSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _SkeletonCard()),
        SizedBox(width: 12),
        Expanded(child: _SkeletonCard()),
        SizedBox(width: 12),
        Expanded(child: _SkeletonCard()),
      ],
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: SizedBox(height: 78, child: LoadingPanel(label: '')),
      ),
    );
  }
}

class _RecentSkeleton extends StatelessWidget {
  const _RecentSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(22),
        child: LoadingPanel(label: 'Loading recent reports…'),
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: StartupSenseColors.muted),
              ),
            ),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

String _shortDate(DateTime date) =>
    '${date.toLocal().year.toString().padLeft(4, '0')}-'
    '${date.toLocal().month.toString().padLeft(2, '0')}-'
    '${date.toLocal().day.toString().padLeft(2, '0')}';
