import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navigation/navigation.dart';
import 'package:patrol/patrol.dart';
import 'package:testing_playground/main_initialization.dart';
import 'package:testing_playground/testing_playground_app.dart';

void main() {
  patrolTest(
    'App loads correctly with empty data',
    (PatrolIntegrationTester $) async {
      await mainInitialization();
      await $.pumpWidgetAndSettle(const TestingPlaygroundApp());

      expect(find.byKey(MedicationsKeys.addMedicationButton), findsOneWidget);
      expect(find.byKey(MedicationsKeys.useMedicationButton), findsNothing);
      expect(find.text('No medications have been added yet'), findsOneWidget);
    },
  );

  patrolTest(
    'App loads correctly with existing data',
    (PatrolIntegrationTester $) async {
      await mainInitialization();

      final AddMedicationBatchUseCase useCase = appLocator.get<AddMedicationBatchUseCase>();
      await useCase.execute(
        AddMedicationBatchPayload(
          medicationName: 'Medication 2',
          quantity: 100,
          expiresAt: DateTime(2042),
        ),
      );
      await useCase.execute(
        AddMedicationBatchPayload(
          medicationName: 'Medication 1',
          quantity: 100,
          expiresAt: DateTime(2044),
        ),
      );

      await $.pumpWidgetAndSettle(const TestingPlaygroundApp());

      expect(find.byKey(MedicationsKeys.addMedicationButton), findsOneWidget);
      expect(find.byKey(MedicationsKeys.useMedicationButton), findsOneWidget);
      expect(find.text('No medications have been added yet'), findsNothing);
      expect(find.textContaining('2042'), findsOneWidget);
      expect(find.textContaining('2044'), findsOneWidget);
    },
  );
}
