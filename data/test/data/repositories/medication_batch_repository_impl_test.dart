import 'package:data/data.dart';
import 'package:domain/src/models/medication_batch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

import 'fakes/fake_medication_batch_provider.dart';

void main() {
  late FakeMedicationBatchProvider fakeBatchProvider;
  late MedicationBatchRepositoryImpl medicationBatchRepository;

  setUp(() {
    fakeBatchProvider = FakeMedicationBatchProvider();
    medicationBatchRepository = MedicationBatchRepositoryImpl(batchProvider: fakeBatchProvider);
  });

  group('consumeMedication', () {
    test('successfully consumes medication and updates quantity', () async {
      await fakeBatchProvider.createMedicationBatch(
        medicationId: 1,
        quantity: 10,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      final MedicationBatch batch = await medicationBatchRepository.consumeMedication(
        batchId: 1,
        quantityToConsume: 5,
      );

      expect(batch.quantity, 5);
    });

    test('deletes batch when quantity reaches zero', () async {
      await fakeBatchProvider.createMedicationBatch(
        medicationId: 1,
        quantity: 5,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      await medicationBatchRepository.consumeMedication(
        batchId: 1,
        quantityToConsume: 5,
      );

      final MedicationBatchTableData? batch =
          await fakeBatchProvider.fetchMedicationBatch(batchId: 1);

      expect(batch, matcher.isNull);
    });
  });

  group('createMedicationBatch', () {
    test('successfully creates a medication batch', () async {
      final MedicationBatch batch = await medicationBatchRepository.createMedicationBatch(
        medicationId: 1,
        quantity: 10,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      expect(batch.medicationId, 1);
      expect(batch.quantity, 10);
    });
  });

  group('deleteMedicationBatch', () {
    test('successfully deletes a medication batch', () async {
      await fakeBatchProvider.createMedicationBatch(
        medicationId: 1,
        quantity: 10,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      await medicationBatchRepository.deleteMedicationBatch(batchId: 1);

      expect(await fakeBatchProvider.fetchMedicationBatch(batchId: 1), matcher.isNull);
    });
  });

  group('fetchMedicationBatches', () {
    test('successfully fetches medication batches', () async {
      await fakeBatchProvider.createMedicationBatch(
        medicationId: 1,
        quantity: 10,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      await fakeBatchProvider.createMedicationBatch(
        medicationId: 2,
        quantity: 5,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      final List<MedicationBatch> batches =
          await medicationBatchRepository.fetchMedicationBatches();

      expect(batches.length, 2);
    });

    test('filters medication batches by medicationId', () async {
      await fakeBatchProvider.createMedicationBatch(
        medicationId: 1,
        quantity: 10,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );
      await fakeBatchProvider.createMedicationBatch(
        medicationId: 2,
        quantity: 5,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      final List<MedicationBatch> batches =
          await medicationBatchRepository.fetchMedicationBatches(medicationId: 1);

      expect(batches.length, 1);
      expect(batches[0].medicationId, 1);
    });
  });
}
