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
            expiresAt: expiresAt,
            availableQuantity: quantity,
            reservedQuantity: 0,
          ),
        );

    return StoredMedication(
      id: id,
      medicationId: medicationId,
      availableQuantity: quantity,
      reservedQuantity: 0,
      expiresAt: expiresAt,
    );
  }

  @override
  Future<Medication> ensureMedicationCreated({required String name}) async {
    final int id = await _appDatabase.into(_appDatabase.medicationTable).insert(
          MedicationTableCompanion.insert(name: name),
          mode: InsertMode.insertOrIgnore,
        );

    return Medication(
      id: id,
      name: name,
    );
  }

  @override
  Future<List<Medication>> fetchMedications() async {
    final List<MedicationTableData> entities =
        await _appDatabase.select(_appDatabase.medicationTable).get();

    return entities.mapList(
      (MedicationTableData item) => Medication(id: item.id, name: item.name),
    );
  }

  @override
  Future<List<StoredMedication>> fetchStoredMedications({
    DateTime? minExpirationDate,
    String? medicationName,
    int? minQuantity,
  }) async {
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
  Future<void> removeStoredMedication({required int id}) async {
    await (_appDatabase.delete(_appDatabase.storedMedicationTable)
          ..where(($StoredMedicationTableTable row) => row.id.equals(id)))
        .go();
  }

  @override
  Future<void> consumeStoredMedication({
    required int id,
    required int quantity,
  }) async {
    await (_appDatabase.update(_appDatabase.storedMedicationTable)
          ..where(($StoredMedicationTableTable row) => row.id.equals(id)))
        .write(
      StoredMedicationTableCompanion.custom(
        reservedQuantity:
            _appDatabase.storedMedicationTable.reservedQuantity - Variable<int>(quantity),
      ),
    );
  }

  @override
  Future<void> releaseStoredMedication({
    required int id,
    required int quantity,
  }) async {
    await (_appDatabase.update(_appDatabase.storedMedicationTable)
          ..where(($StoredMedicationTableTable row) => row.id.equals(id)))
        .write(
      StoredMedicationTableCompanion.custom(
        reservedQuantity:
            _appDatabase.storedMedicationTable.reservedQuantity - Variable<int>(quantity),
        availableQuantity:
            _appDatabase.storedMedicationTable.reservedQuantity + Variable<int>(quantity),
      ),
    );
  }

  @override
  Future<void> reserveStoredMedication({
    required int id,
    required int quantity,
  }) async {
    await (_appDatabase.update(_appDatabase.storedMedicationTable)
          ..where(($StoredMedicationTableTable row) => row.id.equals(id)))
        .write(
      StoredMedicationTableCompanion.custom(
        reservedQuantity:
            _appDatabase.storedMedicationTable.reservedQuantity + Variable<int>(quantity),
        availableQuantity:
            _appDatabase.storedMedicationTable.reservedQuantity - Variable<int>(quantity),
      ),
    );
  }
}
