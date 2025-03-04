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
            initialQuantity: quantity,
            quantity: quantity,
          ),
        );

    return StoredMedication(
      id: id,
      medicationId: medicationId,
      quantity: quantity,
      initialQuantity: quantity,
      expiresAt: expiresAt,
    );
  }

  @override
  Future<StoredMedication> adjustStoredMedicationQuantity({
    required int storedMedicationId,
    required int quantityChange,
  }) async {
    await (_appDatabase.update(_appDatabase.storedMedicationTable)
          ..where(($StoredMedicationTableTable row) => row.id.equals(storedMedicationId)))
        .write(
      StoredMedicationTableCompanion.custom(
        quantity: _appDatabase.storedMedicationTable.quantity - Variable<int>(quantityChange),
      ),
    );

    final StoredMedicationTableData entity =
        await (_appDatabase.select(_appDatabase.storedMedicationTable)
              ..where(($StoredMedicationTableTable row) => row.id.equals(storedMedicationId)))
            .getSingle();

    return StoredMedicationMapper.fromEntity(entity);
  }

  @override
  Future<void> deleteStoredMedication({required int id}) async {
    await (_appDatabase.delete(_appDatabase.storedMedicationTable)
          ..where(($StoredMedicationTableTable row) => row.id.equals(id)))
        .go();
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
  Future<Medication> fetchOrCreateMedication({required String name}) async {
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
  Future<Medication?> searchMedication({required String name}) async {
    final MedicationTableData? entity = await (_appDatabase.select(_appDatabase.medicationTable)
          ..where(($MedicationTableTable row) => row.name.equals(name)))
        .getSingleOrNull();

    if (entity != null) {
      return Medication(
        id: entity.id,
        name: entity.name,
      );
    }

    return null;
  }

  @override
  Future<List<StoredMedication>> fetchStoredMedications({
    DateTime? minExpirationDate,
    int? medicationId,
    int? minQuantity,
  }) async {
    final SimpleSelectStatement<$StoredMedicationTableTable, StoredMedicationTableData> query =
        _appDatabase.select(_appDatabase.storedMedicationTable);

    if (medicationId != null) {
      query.where(($StoredMedicationTableTable t) => t.medicationId.equals(medicationId));
    }

    if (minQuantity != null) {
      query.where(($StoredMedicationTableTable t) => t.quantity.isBiggerOrEqualValue(minQuantity));
    }

    if (minExpirationDate != null) {
      query.where(
          ($StoredMedicationTableTable t) => t.expiresAt.isSmallerOrEqualValue(minExpirationDate));
    }

    query.orderBy(<OrderClauseGenerator<$StoredMedicationTableTable>>[
      ($StoredMedicationTableTable t) => OrderingTerm(expression: t.expiresAt),
    ]);

    final List<StoredMedicationTableData> entities = await query.get();

    return entities.mapList(StoredMedicationMapper.fromEntity);
  }
}
