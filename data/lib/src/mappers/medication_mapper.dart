import 'package:domain/domain.dart';

import '../../data.dart';

final class MedicationMapper {
  const MedicationMapper._();

  static Medication fromEntity(MedicationTableData entity) {
    return Medication(
      id: entity.id,
      name: entity.name,
    );
  }
}
