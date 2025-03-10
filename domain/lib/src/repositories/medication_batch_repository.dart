import '../../domain.dart';

abstract interface class MedicationBatchRepository {
  Future<List<MedicationBatch>> fetchMedicationBatches({
    int? medicationId,
    DateTime? minExpirationDate,
    int? minRemainingQuantity,
  });

  Future<MedicationBatch> createMedicationBatch({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  });

  Future<void> deleteMedicationBatch({required int batchId});

  Future<MedicationBatch> consumeMedication({
    required int batchId,
    required int quantityToConsume,
  });
}
