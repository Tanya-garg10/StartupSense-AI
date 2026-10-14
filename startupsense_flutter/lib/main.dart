import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'client.dart';
import 'features/shell/startup_sense_shell.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const StartupSenseApp());
}

class StartupSenseApp extends StatelessWidget {
  const StartupSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.manropeTextTheme();
    return MaterialApp(
      title: 'StartupSense AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: StartupSenseColors.colorScheme,
        scaffoldBackgroundColor: StartupSenseColors.canvas,
        textTheme: textTheme.copyWith(
          displayLarge: GoogleFonts.dmSerifDisplay(
            textStyle: textTheme.displayLarge,
            color: StartupSenseColors.ink,
          ),
          displayMedium: GoogleFonts.dmSerifDisplay(
            textStyle: textTheme.displayMedium,
            color: StartupSenseColors.ink,
          ),
          headlineLarge: GoogleFonts.dmSerifDisplay(
            textStyle: textTheme.headlineLarge,
            color: StartupSenseColors.ink,
          ),
          headlineMedium: GoogleFonts.dmSerifDisplay(
            textStyle: textTheme.headlineMedium,
            color: StartupSenseColors.ink,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          hintStyle: const TextStyle(color: StartupSenseColors.muted),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: StartupSenseColors.line),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: StartupSenseColors.line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: StartupSenseColors.violet,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: StartupSenseColors.colorScheme.error),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: StartupSenseColors.line),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: StartupSenseColors.ink,
            foregroundColor: Colors.white,
            minimumSize: const Size(48, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      home: ValueListenableBuilder(
        valueListenable: client.auth.authInfoListenable,
        builder: (context, _, _) {
          if (!client.auth.isAuthenticated) {
            return const _WelcomeScreen();
          }
          return const StartupSenseShell();
        },
      ),
    );
  }
}

class _WelcomeScreen extends StatelessWidget {
  const _WelcomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 780;
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Padding(
                  padding: EdgeInsets.all(compact ? 22 : 52),
                  child: compact
                      ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _WelcomeStory(compact: true),
                              const SizedBox(height: 24),
                              _SignInCard(),
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            const Expanded(
                              flex: 5,
                              child: _WelcomeStory(compact: false),
                            ),
                            const SizedBox(width: 52),
                            const Expanded(flex: 4, child: _SignInCard()),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SignInCard extends StatelessWidget {
  const _SignInCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SignInWidget(
          client: client,
          onAuthenticated: () {},
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign-in failed: $error')),
            );
          },
        ),
      ),
    );
  }
}

class _WelcomeStory extends StatelessWidget {
  const _WelcomeStory({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _BrandLockup(),
        SizedBox(height: compact ? 24 : 48),
        Text(
          'Validate Your Idea.\nBuild With Confidence.',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: StartupSenseColors.ink,
            height: 1.08,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'A clearer first step for founders: pressure-test your idea, '
          'surface the unknowns, and decide what to learn next.',
          style: TextStyle(
            color: StartupSenseColors.muted,
            height: 1.7,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        const _TrustNote(
          icon: Icons.shield_outlined,
          text: 'Your saved reports are private to your account.',
        ),
        const SizedBox(height: 10),
        const _TrustNote(
          icon: Icons.lightbulb_outline,
          text: 'AI suggestions are hypotheses, not promises.',
        ),
      ],
    );
  }
}

class _BrandLockup extends StatelessWidget {
  const _BrandLockup();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: StartupSenseColors.ink,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.auto_graph_rounded,
            color: StartupSenseColors.lime,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'StartupSense',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(width: 6),
        const _AiBadge(),
      ],
    );
  }
}

class _AiBadge extends StatelessWidget {
  const _AiBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: StartupSenseColors.lavender,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'AI',
        style: TextStyle(
          color: StartupSenseColors.violet,
          fontWeight: FontWeight.w800,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _TrustNote extends StatelessWidget {
  const _TrustNote({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 19, color: StartupSenseColors.violet),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: StartupSenseColors.muted,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
