import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:startupsense_client/startupsense_client.dart';

import '../../client.dart';
import '../../data/startup_sense_repository.dart';
import '../../theme.dart';
import '../../widgets/sense_widgets.dart';
import '../analysis/idea_form_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../reports/analysis_report_screen.dart';
import '../reports/saved_reports_screen.dart';

enum _WorkspacePage { dashboard, history, form, report, loadingReport }

class StartupSenseShell extends StatefulWidget {
  const StartupSenseShell({super.key});

  @override
  State<StartupSenseShell> createState() => _StartupSenseShellState();
}

class _StartupSenseShellState extends State<StartupSenseShell> {
  final _repository = StartupSenseRepository();
  _WorkspacePage _page = _WorkspacePage.dashboard;
  AnalysisResponse? _analysis;
  bool _returnToHistory = false;

  void _startAnalysis() {
    setState(() {
      _analysis = null;
      _page = _WorkspacePage.form;
    });
  }

  void _analysisCompleted(AnalysisResponse analysis) {
    setState(() {
      _analysis = analysis;
      _returnToHistory = false;
      _page = _WorkspacePage.report;
    });
  }

  Future<void> _openReport(int id, {required bool fromHistory}) async {
    setState(() {
      _page = _WorkspacePage.loadingReport;
      _returnToHistory = fromHistory;
    });
    try {
      final analysis = await _repository.getAnalysis(id);
      if (!mounted) return;
      setState(() {
        _analysis = analysis;
        _page = _WorkspacePage.report;
      });
    } on StartupSenseError catch (error) {
      if (!mounted) return;
      setState(() {
        _page = fromHistory ? _WorkspacePage.history : _WorkspacePage.dashboard;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } on Exception {
      if (!mounted) return;
      setState(() {
        _page = fromHistory ? _WorkspacePage.history : _WorkspacePage.dashboard;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open this report. Please try again.'),
        ),
      );
    }
  }

  void _navigate(int index) {
    setState(() {
      _analysis = null;
      _page = index == 0 ? _WorkspacePage.dashboard : _WorkspacePage.history;
    });
  }

  Future<void> _signOut() async {
    try {
      await client.auth.signOutDevice();
    } on Exception {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign out failed. Please try again.')),
      );
    }
  }

  String get _title => switch (_page) {
    _WorkspacePage.dashboard => 'Overview',
    _WorkspacePage.history => 'Saved reports',
    _WorkspacePage.form => 'New analysis',
    _WorkspacePage.report => 'Analysis report',
    _WorkspacePage.loadingReport => 'Opening report',
  };

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 980;
        final selectedIndex = _page == _WorkspacePage.history ? 1 : 0;
        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (desktop)
                  _DesktopNavigation(
                    selectedIndex: selectedIndex,
                    onSelect: _navigate,
                    onAnalyze: _startAnalysis,
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _TopBar(
                        title: _title,
                        desktop: desktop,
                        onSignOut: _signOut,
                        onHome: () => _navigate(0),
                      ),
                      Expanded(child: _buildPage()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: desktop
              ? null
              : NavigationBar(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: _navigate,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.space_dashboard_outlined),
                      selectedIcon: Icon(Icons.space_dashboard_rounded),
                      label: 'Overview',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.folder_open_outlined),
                      selectedIcon: Icon(Icons.folder_rounded),
                      label: 'Saved',
                    ),
                  ],
                ),
          floatingActionButton:
              desktop ||
                  _page == _WorkspacePage.form ||
                  _page == _WorkspacePage.loadingReport
              ? null
              : FloatingActionButton.extended(
                  onPressed: _startAnalysis,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Analyze idea'),
                ),
        );
      },
    );
  }

  Widget _buildPage() {
    return switch (_page) {
      _WorkspacePage.dashboard => DashboardScreen(
        key: const ValueKey('dashboard'),
        onAnalyze: _startAnalysis,
        onOpenReport: (id) => _openReport(id, fromHistory: false),
        onOpenHistory: () => _navigate(1),
      ),
      _WorkspacePage.history => SavedReportsScreen(
        key: const ValueKey('history'),
        onAnalyze: _startAnalysis,
        onOpenReport: (id) => _openReport(id, fromHistory: true),
      ),
      _WorkspacePage.form => IdeaFormScreen(
        key: const ValueKey('form'),
        onAnalyzed: _analysisCompleted,
      ),
      _WorkspacePage.report when _analysis != null => AnalysisReportScreen(
        key: ValueKey('report-${_analysis!.id}'),
        analysis: _analysis!,
        onBack: () => _navigate(_returnToHistory ? 1 : 0),
      ),
      _WorkspacePage.loadingReport => const LoadingPanel(
        label: 'Loading the saved report…',
      ),
      _ => const ErrorNotice(
        message: 'The report is not available. Return to your workspace.',
      ),
    };
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.desktop,
    required this.onSignOut,
    required this.onHome,
  });

  final String title;
  final bool desktop;
  final VoidCallback onSignOut;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: desktop ? 30 : 18),
        child: Row(
          children: [
            if (!desktop) ...[
              IconButton(
                tooltip: 'Go to overview',
                onPressed: onHome,
                icon: const Icon(Icons.auto_graph_rounded),
                color: StartupSenseColors.violet,
              ),
              const SizedBox(width: 4),
            ],
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const InlinePill(
              label: 'PRIVATE WORKSPACE',
              color: StartupSenseColors.paleTeal,
              foregroundColor: StartupSenseColors.teal,
            ),
            const SizedBox(width: 10),
            IconButton(
              tooltip: 'Sign out',
              onPressed: onSignOut,
              icon: const Icon(Icons.logout_rounded),
              color: StartupSenseColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopNavigation extends StatelessWidget {
  const _DesktopNavigation({
    required this.selectedIndex,
    required this.onSelect,
    required this.onAnalyze,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onAnalyze;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 246,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Brand(),
          const SizedBox(height: 36),
          const Padding(
            padding: EdgeInsets.only(left: 12, bottom: 8),
            child: EyebrowLabel('WORKSPACE'),
          ),
          _NavItem(
            icon: Icons.space_dashboard_outlined,
            label: 'Overview',
            selected: selectedIndex == 0,
            onTap: () => onSelect(0),
          ),
          _NavItem(
            icon: Icons.folder_open_outlined,
            label: 'Saved reports',
            selected: selectedIndex == 1,
            onTap: () => onSelect(1),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: StartupSenseColors.ink,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.tips_and_updates_outlined,
                  color: StartupSenseColors.lime,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Better questions\nbefore bigger bets.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onAnalyze,
                    style: FilledButton.styleFrom(
                      backgroundColor: StartupSenseColors.lime,
                      foregroundColor: StartupSenseColors.ink,
                      minimumSize: const Size(0, 42),
                    ),
                    child: const Text('New analysis'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Decision support, not a success guarantee.',
            style: TextStyle(
              color: StartupSenseColors.muted,
              fontSize: 11,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: StartupSenseColors.ink,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.auto_graph_rounded,
            color: StartupSenseColors.lime,
            size: 21,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'StartupSense',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(width: 5),
        const InlinePill(label: 'AI'),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        onTap: onTap,
        selected: selected,
        selectedTileColor: StartupSenseColors.lavender,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        leading: Icon(
          icon,
          color: selected
              ? StartupSenseColors.violet
              : StartupSenseColors.muted,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: selected
                ? StartupSenseColors.violet
                : StartupSenseColors.muted,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
