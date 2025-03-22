import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  late AppDatabase database;
  late MedicationBatchProviderImpl provider;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    provider = MedicationBatchProviderImpl(appDatabase: database);
  });

  tearDown(() async => database.close());

  group('fetchMedicationBatches', () {
    test('returns an empty list when no medication batches exist', () async {
      final List<MedicationBatchTableData> batches = await provider.fetchMedicationBatches();
      expect(batches, isEmpty);
    });

    test('returns the correct list of medication batches', () async {
      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: DateTime.now().add(const Duration(days: 30)),
            ),
          );

      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 2,
              quantity: 50,
              initialQuantity: 50,
              expiresAt: DateTime.now().add(const Duration(days: 60)),
            ),
          );

      final List<MedicationBatchTableData> batches = await provider.fetchMedicationBatches();

      expect(batches.length, 2);
      expect(batches.map((MedicationBatchTableData batch) => batch.medicationId), contains(1));
      expect(batches.map((MedicationBatchTableData batch) => batch.medicationId), contains(2));
    });

    test('applies medication ID filter correctly', () async {
      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: DateTime.now().add(const Duration(days: 30)),
            ),
          );

      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 2,
              quantity: 50,
              initialQuantity: 50,
              expiresAt: DateTime.now().add(const Duration(days: 60)),
            ),
          );

      final List<MedicationBatchTableData> batches = await provider.fetchMedicationBatches(
        medicationId: 1,
      );

      expect(batches.length, 1);
      expect(batches.first.medicationId, 1);
    });

    test('applies expiration date filter correctly', () async {
      final DateTime now = DateTime.now();

      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: now.add(const Duration(days: 30)),
            ),
          );

      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 2,
              quantity: 50,
              initialQuantity: 50,
              expiresAt: now.add(const Duration(days: 10)),
            ),
          );

      final List<MedicationBatchTableData> batches = await provider.fetchMedicationBatches(
        minExpirationDate: now.add(const Duration(days: 20)),
      );

      expect(batches.length, 1);
      expect(batches.first.medicationId, 1);
    });

    test('applies remaining quantity filter correctly', () async {
      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: DateTime.now().add(const Duration(days: 30)),
            ),
          );

      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 2,
              quantity: 50,
              initialQuantity: 50,
              expiresAt: DateTime.now().add(const Duration(days: 60)),
            ),
          );

      final List<MedicationBatchTableData> batches = await provider.fetchMedicationBatches(
        minRemainingQuantity: 75,
      );

      expect(batches.length, 1);
      expect(batches.first.medicationId, 1);
    });

    test('combines multiple filters correctly', () async {
      final DateTime now = DateTime.now();

      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: now.add(const Duration(days: 30)),
            ),
          );

      await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 2,
              quantity: 50,
              initialQuantity: 50,
              expiresAt: now.add(const Duration(days: 10)),
            ),
          );

      final List<MedicationBatchTableData> batches = await provider.fetchMedicationBatches(
        medicationId: 1,
        minExpirationDate: now.add(const Duration(days: 15)),
      );

      expect(batches.length, 1);
      expect(batches.first.medicationId, 1);
    });
  });

  group('fetchMedicationBatch', () {
    test('returns a medication batch when a valid batch ID is provided', () async {
      final DateTime expiresAt = DateTime.now().add(const Duration(days: 30));

      final int batchId = await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: expiresAt,
            ),
          );

      final MedicationBatchTableData? batch = await provider.fetchMedicationBatch(batchId: batchId);

      expect(batch, matcher.isNotNull);
      expect(batch!.id, batchId);
      expect(batch.medicationId, 1);
      expect(batch.quantity, 100);
      expect(batch.initialQuantity, 100);
      expect(batch.expiresAt, expiresAt.copyWith(millisecond: 0, microsecond: 0));
    });

    test('returns null when an invalid batch ID is provided', () async {
      final MedicationBatchTableData? batch = await provider.fetchMedicationBatch(batchId: 999);
      expect(batch, matcher.isNull);
    });
  });

  group('createMedicationBatch', () {
    test('successfully creates a medication batch', () async {
      final MedicationBatchTableData batch = await provider.createMedicationBatch(
        medicationId: 1,
        quantity: 100,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      final MedicationBatchTableData? fetchedBatch = await provider.fetchMedicationBatch(
        batchId: batch.id,
      );

      expect(batch.medicationId, 1);
      expect(batch.quantity, 100);
      expect(batch.initialQuantity, 100);
      expect(fetchedBatch, batch);
    });
  });

  group('deleteMedicationBatch', () {
    test('successfully deletes an existing medication batch', () async {
      final int batchId = await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: DateTime.now().add(const Duration(days: 30)),
            ),
          );

      await provider.deleteMedicationBatch(batchId: batchId);

      final MedicationBatchTableData? deletedBatch = await provider.fetchMedicationBatch(
        batchId: batchId,
      );

      expect(deletedBatch, matcher.isNull);
    });

    test('does nothing when trying to delete a non-existent batch', () async {
      await provider.deleteMedicationBatch(batchId: 999);
      expect(true, true);
    });
  });

  group('consumeMedication', () {
    test('successfully consumes medication from a batch', () async {
      final int batchId = await database.into(database.medicationBatchTable).insert(
            MedicationBatchTableCompanion.insert(
              medicationId: 1,
              quantity: 100,
              initialQuantity: 100,
              expiresAt: DateTime.now().add(const Duration(days: 30)),
            ),
          );

      const int quantityToConsume = 30;

      await provider.consumeMedication(
        batchId: batchId,
        quantityToConsume: quantityToConsume,
      );

      final MedicationBatchTableData updatedBatch =
          await (database.select(database.medicationBatchTable)
                // ignore: always_specify_types
                ..where((row) => row.id.equals(batchId)))
              .getSingle();

      expect(updatedBatch, matcher.isNotNull);
      expect(updatedBatch.quantity, 70);
      expect(updatedBatch.initialQuantity, 100);
    });
  });
}
