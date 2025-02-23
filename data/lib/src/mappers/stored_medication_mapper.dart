import 'package:domain/domain.dart';

import '../../data.dart';

final class StoredMedicationMapper {
  const StoredMedicationMapper._();

  static StoredMedication fromEntity(StoredMedicationTableData entity) {
    return StoredMedication(
      id: entity.id,
      medicationId: entity.medicationId,
      quantity: entity.quantity,
      expiresAt: entity.expiresAt,
    );
  }
}
