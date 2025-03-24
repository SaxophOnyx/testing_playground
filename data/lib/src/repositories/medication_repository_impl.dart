import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class MedicationRepositoryImpl implements MedicationRepository {
  final MedicationProvider _medicationProvider;

  const MedicationRepositoryImpl({
    required MedicationProvider medicationProvider,
  }) : _medicationProvider = medicationProvider;

  @override
  Future<List<Medication>> fetchMedications() async {
    try {
      final List<MedicationTableData> entities = await _medicationProvider.fetchMedications();
      return entities.mapList(MedicationMapper.fromEntity);
    } catch (_) {
      throw const AppException.unknown();
    }
  }

  @override
  Future<Medication?> retrieveMedicationByName({
    required String name,
    required bool createIfNotExist,
  }) async {
    try {
      final MedicationTableData? entity = createIfNotExist
          ? await _medicationProvider.searchOrCreateMedicationByName(name: name)
          : await _medicationProvider.searchMedicationByName(name: name);

      return entity != null ? MedicationMapper.fromEntity(entity) : null;
    } catch (_) {
      throw const AppException.unknown();
    }
  }
}
