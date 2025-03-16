// ignore_for_file: always_specify_types

import '../../data.dart';

abstract interface class MedicationBatchProvider {
  Future<List<MedicationBatchTableData>> fetchMedicationBatches({
    int? medicationId,
    DateTime? minExpirationDate,
    int? minRemainingQuantity,
  });

  Future<MedicationBatchTableData?> fetchMedicationBatch({required int batchId});

  Future<MedicationBatchTableData> createMedicationBatch({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  });

  Future<void> deleteMedicationBatch({required int batchId});

  Future<void> consumeMedication({
    required int batchId,
    required int quantityToConsume,
  });
}

final class MedicationBatchProviderImpl implements MedicationBatchProvider {
  final AppDatabase _database;

  const MedicationBatchProviderImpl({
    required AppDatabase appDatabase,
  }) : _database = appDatabase;

  @override
  Future<List<MedicationBatchTableData>> fetchMedicationBatches({
    int? medicationId,
    DateTime? minExpirationDate,
    int? minRemainingQuantity,
  }) async {
    final query = _database.select(_database.medicationBatchTable);

    if (medicationId != null) {
      query.where((row) => row.medicationId.equals(medicationId));
    }

    if (minExpirationDate != null) {
      query.where((row) => row.expiresAt.isBiggerOrEqualValue(minExpirationDate));
    }

    if (minRemainingQuantity != null) {
      query.where((row) => row.quantity.isBiggerOrEqualValue(minRemainingQuantity));
    }

    return query.get();
  }

  @override
  Future<MedicationBatchTableData?> fetchMedicationBatch({required int batchId}) {
    return (_database.select(_database.medicationBatchTable)
          ..where((row) => row.id.equals(batchId)))
        .getSingleOrNull();
  }

  @override
  Future<MedicationBatchTableData> createMedicationBatch({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  }) async {
    final int id = await _database.into(_database.medicationBatchTable).insert(
          MedicationBatchTableCompanion.insert(
            medicationId: medicationId,
            expiresAt: expiresAt,
            initialQuantity: quantity,
            quantity: quantity,
          ),
        );

    return MedicationBatchTableData(
      id: id,
      medicationId: medicationId,
      quantity: quantity,
      initialQuantity: quantity,
      expiresAt: expiresAt.copyWith(
        millisecond: 0,
        microsecond: 0,
      ),
    );
  }

  @override
  Future<void> deleteMedicationBatch({required int batchId}) {
    return (_database.delete(_database.medicationBatchTable)
          ..where((row) => row.id.equals(batchId)))
        .go();
  }

  @override
  Future<void> consumeMedication({
    required int batchId,
    required int quantityToConsume,
  }) {
    return (_database.update(_database.medicationBatchTable)
          ..where((row) => row.id.equals(batchId)))
        .write(
      MedicationBatchTableCompanion.custom(
        quantity: _database.medicationBatchTable.quantity - Variable<int>(quantityToConsume),
      ),
    );
  }
}
