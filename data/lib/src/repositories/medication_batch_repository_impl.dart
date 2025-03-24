import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class MedicationBatchRepositoryImpl implements MedicationBatchRepository {
  final MedicationBatchProvider _batchProvider;

  const MedicationBatchRepositoryImpl({
    required MedicationBatchProvider batchProvider,
  }) : _batchProvider = batchProvider;

  @override
  Future<MedicationBatch> consumeMedication({
    required int batchId,
    required int quantityToConsume,
  }) async {
    await _batchProvider.consumeMedication(
      batchId: batchId,
      quantityToConsume: quantityToConsume,
    );

    final MedicationBatchTableData? entity = await _batchProvider.fetchMedicationBatch(
      batchId: batchId,
    );

    if (entity == null) {
      throw const AppException.unknown();
    }

    if (entity.quantity == 0) {
      await _batchProvider.deleteMedicationBatch(batchId: batchId);
    }

    return MedicationBatchMapper.fromEntity(entity);
  }

  @override
  Future<MedicationBatch> createMedicationBatch({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  }) async {
    final MedicationBatchTableData entity = await _batchProvider.createMedicationBatch(
      medicationId: medicationId,
      quantity: quantity,
      expiresAt: expiresAt,
    );

    return MedicationBatchMapper.fromEntity(entity);
  }

  @override
  Future<void> deleteMedicationBatch({required int batchId}) {
    return _batchProvider.deleteMedicationBatch(batchId: batchId);
  }

  @override
  Future<List<MedicationBatch>> fetchMedicationBatches({
    int? medicationId,
    DateTime? minExpirationDate,
    int? minRemainingQuantity,
  }) async {
    final List<MedicationBatchTableData> entities = await _batchProvider.fetchMedicationBatches(
      medicationId: medicationId,
      minExpirationDate: minExpirationDate,
      minRemainingQuantity: minRemainingQuantity,
    );

    return entities.mapList(MedicationBatchMapper.fromEntity);
  }
}
