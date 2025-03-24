import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medications/src/widgets/medication_batch_floating_buttons.dart';

void main() {
  testWidgets(
    'has zero size when isWidgetVisible is false',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MedicationBatchFloatingButtons(
              isWidgetVisible: false,
              isUseButtonVisible: true,
              onAddMedication: () {},
              onUseMedication: () {},
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(MedicationBatchFloatingButtons)), Size.zero);
    },
  );

  testWidgets(
    'UseMedication button is not presented when isUseButtonVisible is false',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MedicationBatchFloatingButtons(
              isWidgetVisible: true,
              isUseButtonVisible: false,
              onAddMedication: () {},
              onUseMedication: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.healing), findsNothing);
    },
  );

  testWidgets(
    'both buttons are presented when isWidgetVisible and isUseButtonVisible are true',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MedicationBatchFloatingButtons(
              isWidgetVisible: true,
              isUseButtonVisible: true,
              onAddMedication: () {},
              onUseMedication: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.healing), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    },
  );
}
