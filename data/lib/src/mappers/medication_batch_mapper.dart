import 'package:domain/domain.dart';

import '../../data.dart';

final class MedicationBatchMapper {
  const MedicationBatchMapper._();

  static MedicationBatch fromEntity(MedicationBatchTableData entity) {
    return MedicationBatch(
      id: entity.id,
      medicationId: entity.medicationId,
      quantity: entity.quantity,
      initialQuantity: entity.initialQuantity,
      expiresAt: entity.expiresAt,
    );
  }
}
