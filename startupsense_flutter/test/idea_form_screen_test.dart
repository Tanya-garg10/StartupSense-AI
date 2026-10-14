import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startupsense_flutter/features/analysis/idea_form_screen.dart';

void main() {
  testWidgets('requires the startup details before submitting', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IdeaFormScreen(onAnalyzed: (_) {}),
        ),
      ),
    );

    await tester.ensureVisible(find.byKey(const Key('analyze_idea_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('analyze_idea_button')));
    await tester.pumpAndSettle();

    expect(find.text('This field is required.'), findsNWidgets(5));
    expect(find.text('Enter an amount from 0 to 100,000,000.'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('description_field')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('description_field')),
      'Too short',
    );
    await tester.ensureVisible(find.byKey(const Key('analyze_idea_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('analyze_idea_button')));
    await tester.pumpAndSettle();

    expect(
      find.text('Add a little more detail (at least 30 characters).'),
      findsOneWidget,
    );
    expect(
      find.textContaining('We could not reach StartupSense'),
      findsNothing,
    );
  });
}
