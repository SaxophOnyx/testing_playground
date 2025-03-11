import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class MedicationRepositoryImpl implements MedicationRepository {
  final AppDatabase _appDatabase;

  const MedicationRepositoryImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<List<Medication>> fetchMedications() async {
    final List<MedicationTableData> entities = await _appDatabase.fetchMedications();
    return entities.mapList(MedicationMapper.fromEntity);
  }

  @override
  Future<Medication?> searchMedicationByName({
    required String name,
    bool createIfNotExist = false,
  }) async {
    final MedicationTableData? entity = await _appDatabase.searchMedicationByName(
      name: name,
      createIfNotExist: createIfNotExist,
    );

    return entity != null ? MedicationMapper.fromEntity(entity) : null;
  }
}
