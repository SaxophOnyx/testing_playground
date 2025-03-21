import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:testing_playground/main_initialization.dart';
import 'package:testing_playground/testing_playground_app.dart';

void main() {
  patrolTest('User can delete medications', (PatrolIntegrationTester $) async {
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

    await $.tap(find.byIcon(Icons.delete));
    await $.tap(find.byIcon(Icons.delete));

    expect(find.text('No medications have been added yet'), findsOneWidget);
  });
}
