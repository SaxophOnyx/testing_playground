import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:drift/drift.dart';

import '../../data.dart';

final class MedicationRepositoryImpl implements MedicationRepository {
  final AppDatabase _appDatabase;

  const MedicationRepositoryImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<StoredMedication> addStoredMedication({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  }) async {
    final int id = await _appDatabase.into(_appDatabase.storedMedicationTable).insert(
          StoredMedicationTableCompanion.insert(
            medicationId: medicationId,
            quantity: quantity,
            expiresAt: expiresAt,
          ),
        );

    return StoredMedication(
      id: id,
      medicationId: medicationId,
      quantity: quantity,
      expiresAt: expiresAt,
    );
  }

  @override
  Future<Map<int, Medication>> fetchMedications() async {
    final List<MedicationTableData> entities =
        await _appDatabase.select(_appDatabase.medicationTable).get();

    final Map<int, Medication> map = <int, Medication>{
      for (final MedicationTableData entity in entities)
        entity.id: Medication(
          id: entity.id,
          name: entity.name,
          isSplittable: entity.isSplittable,
        ),
    };

    return map;
  }

  @override
  Future<List<StoredMedication>> fetchStoredMedications() async {
    final List<StoredMedicationTableData> entities =
        await (_appDatabase.select(_appDatabase.storedMedicationTable)
              ..orderBy(
                <OrderClauseGenerator<$StoredMedicationTableTable>>[
                  ($StoredMedicationTableTable t) => OrderingTerm(expression: t.expiresAt)
                ],
              ))
            .get();

    return entities.mapList(StoredMedicationMapper.fromEntity);
  }

  @override
  Future<Medication> fetchOrCreateMedication({
    required String name,
  }) async {
    final int id = await _appDatabase.into(_appDatabase.medicationTable).insert(
          MedicationTableCompanion.insert(
            name: name,
            // TODO(SaxophOyx): Implement
            isSplittable: false,
          ),
          mode: InsertMode.insertOrIgnore,
        );

    return Medication(
      id: id,
      name: name,
      isSplittable: false,
    );
  }
}
