import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navigation/navigation.dart';
import 'package:patrol/patrol.dart';
import 'package:testing_playground/main_initialization.dart';
import 'package:testing_playground/testing_playground_app.dart';

void main() {
  patrolTest('User can use medication with validation', (PatrolIntegrationTester $) async {
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

    await $.tap(find.byKey(MedicationsKeys.useMedicationButton));
    expect(find.byKey(UseMedicationKeys.confirmUsageButton), findsNothing);

    await $.tap(find.byKey(UseMedicationKeys.searchForMedicationButton));
    expect($('Invalid name'), findsOneWidget);
    expect($('Invalid quantity'), findsOneWidget);

    await $.enterText(find.byKey(UseMedicationKeys.nameTextField), 'Wrong name');
    await $.enterText(find.byKey(UseMedicationKeys.quantityTextField), '120');

    await $.tap(
      find.byKey(UseMedicationKeys.searchForMedicationButton),
      settlePolicy: SettlePolicy.noSettle,
    );

    expect($('Invalid name'), findsNothing);
    expect($('Invalid quantity'), findsNothing);

    await $.pumpAndSettle();

    expect($('No suitable medications found'), findsOneWidget);

    await $.enterText(find.byKey(UseMedicationKeys.nameTextField), 'Medication 1');
    await $.tap(find.byKey(UseMedicationKeys.searchForMedicationButton));
    expect($('No suitable medications found'), findsOneWidget);

    await $.enterText(find.byKey(UseMedicationKeys.quantityTextField), '20');
    await $.tap(find.byKey(UseMedicationKeys.searchForMedicationButton));
    expect(find.byKey(UseMedicationKeys.confirmUsageButton), findsOneWidget);
    expect(find.byKey(UseMedicationKeys.searchForMedicationButton), findsNothing);

    await $.tap(find.byKey(UseMedicationKeys.confirmUsageButton));

    expect(find.byKey(UseMedicationKeys.nameTextField), findsNothing);
    expect(find.textContaining('80 unit(s)'), findsAny);
  });

  patrolTest('Medication is deleted if fully used', (PatrolIntegrationTester $) async {
    await mainInitialization();

    final AddMedicationBatchUseCase useCase = appLocator.get<AddMedicationBatchUseCase>();
    await useCase.execute(
      AddMedicationBatchPayload(
        medicationName: 'Medication 1',
        quantity: 100,
        expiresAt: DateTime(2044),
      ),
    );

    await $.pumpWidgetAndSettle(const TestingPlaygroundApp());

    await $.tap(find.byKey(MedicationsKeys.useMedicationButton));
    await $.enterText(find.byKey(UseMedicationKeys.nameTextField), 'Medication 1');
    await $.enterText(find.byKey(UseMedicationKeys.quantityTextField), '20');
    await $.tap(find.byKey(UseMedicationKeys.searchForMedicationButton));
    await $.tap(find.byKey(UseMedicationKeys.confirmUsageButton));

    expect(find.byKey(UseMedicationKeys.nameTextField), findsNothing);
    expect(find.textContaining('80 unit(s)'), findsAny);

    await $.tap(find.byKey(MedicationsKeys.useMedicationButton));
    await $.enterText(find.byKey(UseMedicationKeys.nameTextField), 'Medication 1');
    await $.enterText(find.byKey(UseMedicationKeys.quantityTextField), '80');
    await $.tap(find.byKey(UseMedicationKeys.searchForMedicationButton));
    await $.tap(find.byKey(UseMedicationKeys.confirmUsageButton));

    expect(find.byKey(UseMedicationKeys.nameTextField), findsNothing);
    expect(find.text('No medications have been added yet'), findsOneWidget);
  });
}
