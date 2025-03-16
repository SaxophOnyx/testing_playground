import 'package:collection/collection.dart';
import 'package:data/data.dart';

class FakeMedicationBatchProvider implements MedicationBatchProvider {
  final List<MedicationBatchTableData> _batches =
      List<MedicationBatchTableData>.empty(growable: true);

  @override
  Future<void> consumeMedication({required int batchId, required int quantityToConsume}) async {
    final int index = _batches.indexWhere((MedicationBatchTableData batch) => batch.id == batchId);
    final MedicationBatchTableData batch = _batches[index];

    final MedicationBatchTableData updated = MedicationBatchTableData(
      id: batch.id,
      medicationId: batch.medicationId,
      quantity: batch.quantity - quantityToConsume,
      initialQuantity: batch.initialQuantity,
      expiresAt: batch.expiresAt,
    );

    _batches[index] = updated;
  }

  @override
  Future<MedicationBatchTableData?> fetchMedicationBatch({required int batchId}) async {
    return _batches.firstWhereOrNull((MedicationBatchTableData b) => b.id == batchId);
  }

  @override
  Future<MedicationBatchTableData> createMedicationBatch({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  }) async {
    final MedicationBatchTableData newBatch = MedicationBatchTableData(
      id: _batches.length + 1,
      medicationId: medicationId,
      quantity: quantity,
      expiresAt: expiresAt,
      initialQuantity: quantity,
    );

    _batches.add(newBatch);

    return newBatch;
  }

  @override
  Future<void> deleteMedicationBatch({required int batchId}) async {
    _batches.removeWhere((MedicationBatchTableData b) => b.id == batchId);
  }

  @override
  Future<List<MedicationBatchTableData>> fetchMedicationBatches({
    int? medicationId,
    DateTime? minExpirationDate,
    int? minRemainingQuantity,
  }) async {
    return _batches.where((MedicationBatchTableData b) {
      if (medicationId != null && b.medicationId != medicationId) {
        return false;
      }

      if (minExpirationDate != null && b.expiresAt.isBefore(minExpirationDate)) {
        return false;
      }

      if (minRemainingQuantity != null && b.quantity < minRemainingQuantity) {
        return false;
      }

      return true;
    }).toList();
  }
}
