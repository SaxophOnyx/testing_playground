import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medications/src/widgets/medication_batch_card.dart';

void main() {
  testWidgets('Widget renders passed data in a correct format', (WidgetTester tester) async {
    const String medicationName = 'Medication';

    await tester.pumpWidget(
      MaterialApp(
        home: MedicationBatchCard(
          medicationName: medicationName,
          quantity: 120,
          expiresAt: DateTime(2028, 12, 20),
          onDeletePressed: () {},
        ),
      ),
    );

    expect(find.textContaining(medicationName), findsOneWidget);
    expect(find.textContaining('December 20, 2028'), findsOneWidget);
  });

  testWidgets('Widget renders expired label when batch has expired', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MedicationBatchCard(
          medicationName: 'Medication',
          quantity: 120,
          expiresAt: DateTime(2000, 10, 12),
          onDeletePressed: () {},
        ),
      ),
    );

    expect(find.textContaining('Expired'), findsOneWidget);
  });

  testWidgets(
    'Widget card has  errorContainer when batch has expired',
    (WidgetTester tester) async {
      final GlobalKey<State<StatefulWidget>> contextKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: MedicationBatchCard(
            key: contextKey,
            medicationName: 'Medication',
            quantity: 120,
            expiresAt: DateTime(2000, 10, 12),
            onDeletePressed: () {},
          ),
        ),
      );

      final Widget card = tester.widget(find.byType(Card).first);
      final ColorScheme colors = Theme.of(contextKey.currentContext!).colorScheme;

      expect(
        card,
        isA<Card>().having((Card card) => card.color, 'Card color', colors.errorContainer),
      );
    },
  );
}
