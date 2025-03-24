// ignore_for_file: always_specify_types

import '../../data.dart';

abstract interface class MedicationProvider {
  Future<List<MedicationTableData>> fetchMedications();

  Future<MedicationTableData?> searchMedicationByName({required String name});

  Future<MedicationTableData> searchOrCreateMedicationByName({required String name});
}

final class MedicationProviderImpl implements MedicationProvider {
  final AppDatabase _database;

  const MedicationProviderImpl({
    required AppDatabase appDatabase,
  }) : _database = appDatabase;

  @override
  Future<List<MedicationTableData>> fetchMedications() async {
    return _database.select(_database.medicationTable).get();
  }

  @override
  Future<MedicationTableData?> searchMedicationByName({required String name}) async {
    return (_database.select(_database.medicationTable)..where((row) => row.name.equals(name)))
        .getSingleOrNull();
  }

  @override
  Future<MedicationTableData> searchOrCreateMedicationByName({required String name}) async {
    final int id = await _database.into(_database.medicationTable).insert(
          MedicationTableCompanion.insert(name: name),
          mode: InsertMode.insertOrIgnore,
        );

    return MedicationTableData(
      id: id,
      name: name,
    );
  }
}
