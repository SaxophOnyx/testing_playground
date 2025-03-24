import 'package:flutter_test/flutter_test.dart';
import 'package:navigation/navigation.dart';
import 'package:patrol/patrol.dart';
import 'package:testing_playground/main_initialization.dart';
import 'package:testing_playground/testing_playground_app.dart';

void main() {
  patrolTest(
    'User can create medication with proper validation',
    (PatrolIntegrationTester $) async {
      await _initializeApp($);

      await $.tap(find.byKey(MedicationsKeys.addMedicationButton));

      await $.tap(find.byKey(AddMedicationKeys.submitButton));
      expect($('Invalid name'), findsOneWidget);
      expect($('Invalid quantity'), findsOneWidget);
      expect($('Invalid date'), findsOneWidget);

      await $.enterText(find.byKey(AddMedicationKeys.nameTextField), 'Test Name');
      expect($('Invalid name'), findsNothing);

      await $.enterText(find.byKey(AddMedicationKeys.quantityTextField), '100');
      expect($('Invalid quantity'), findsNothing);

      await $.enterText(find.byKey(AddMedicationKeys.expiresAtTextField), '12122028');
      expect($('Invalid date'), findsNothing);

      await $.tap(find.byKey(AddMedicationKeys.submitButton));

      expect(find.byKey(AddMedicationKeys.submitButton), findsNothing);
      expect($('Test Name'), findsOneWidget);
    },
  );

  patrolTest(
    'User can create multiple medications',
    (PatrolIntegrationTester $) async {
      await _initializeApp($);

      await $.tap(find.byKey(MedicationsKeys.addMedicationButton));
      await $.enterText(find.byKey(AddMedicationKeys.nameTextField), 'Test Name');
      await $.enterText(find.byKey(AddMedicationKeys.quantityTextField), '100');
      await $.enterText(find.byKey(AddMedicationKeys.expiresAtTextField), '12122028');
      await $.tap(find.byKey(AddMedicationKeys.submitButton));

      await $.tap(find.byKey(MedicationsKeys.addMedicationButton));
      await $.enterText(find.byKey(AddMedicationKeys.nameTextField), 'Test Name 2');
      await $.enterText(find.byKey(AddMedicationKeys.quantityTextField), '100');
      await $.enterText(find.byKey(AddMedicationKeys.expiresAtTextField), '12122028');
      await $.tap(find.byKey(AddMedicationKeys.submitButton));

      expect(find.byKey(AddMedicationKeys.submitButton), findsNothing);
      expect($('Test Name'), findsOneWidget);
      expect($('Test Name 2'), findsOneWidget);
    },
  );
}

Future<void> _initializeApp(PatrolIntegrationTester $) async {
  await mainInitialization();
  await $.pumpWidgetAndSettle(const TestingPlaygroundApp());
}
