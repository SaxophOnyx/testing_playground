import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class MedicationBatchRepositoryImpl implements MedicationBatchRepository {
  final AppDatabase _appDatabase;

  const MedicationBatchRepositoryImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<MedicationBatch> consumeMedication({
    required int batchId,
    required int quantityToConsume,
  }) async {
    await _appDatabase.consumeMedication(
      batchId: batchId,
      quantityToConsume: quantityToConsume,
    );

    final MedicationBatchTableData entity = await _appDatabase.fetchMedicationBatch(
      batchId: batchId,
    );

    if (entity.quantity == 0) {
      await _appDatabase.deleteMedicationBatch(batchId: batchId);
    }

    return MedicationBatchMapper.fromEntity(entity);
  }

  @override
  Future<MedicationBatch> createMedicationBatch({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  }) async {
    final MedicationBatchTableData entity = await _appDatabase.createMedicationBatch(
      medicationId: medicationId,
      quantity: quantity,
      expiresAt: expiresAt,
    );

    return MedicationBatchMapper.fromEntity(entity);
  }

  @override
  Future<void> deleteMedicationBatch({required int batchId}) {
    return _appDatabase.deleteMedicationBatch(batchId: batchId);
  }

  @override
  Future<List<MedicationBatch>> fetchMedicationBatches({
    int? medicationId,
    DateTime? minExpirationDate,
    int? minRemainingQuantity,
  }) async {
    final List<MedicationBatchTableData> entities = await _appDatabase.fetchMedicationBatches(
      medicationId: medicationId,
      minExpirationDate: minExpirationDate,
      minRemainingQuantity: minRemainingQuantity,
    );

    return entities.mapList(MedicationBatchMapper.fromEntity);
  }
}
