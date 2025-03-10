// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import '../../data.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: <Type>[
  MedicationTable,
  MedicationBatchTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(
      () async {
        final Directory dbFolder = await getApplicationDocumentsDirectory();
        final File file = File(join(dbFolder.path, 'medication_database'));

        if (Platform.isAndroid) {
          await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
        }

        final String cacheBase = (await getTemporaryDirectory()).path;
        sqlite3.tempDirectory = cacheBase;

        return NativeDatabase.createInBackground(file);
      },
    );
  }

  Future<List<MedicationTableData>> fetchMedications() async {
    return select(medicationTable).get();
  }

  Future<MedicationTableData?> searchMedicationByName({
    required String name,
    required bool createIfNotExist,
  }) async {
    if (createIfNotExist) {
      final int id = await into(medicationTable).insert(
        MedicationTableCompanion.insert(name: name),
        mode: InsertMode.insertOrIgnore,
      );

      return MedicationTableData(
        id: id,
        name: name,
      );
    } else {
      return (select(medicationTable)..where((row) => row.name.equals(name))).getSingleOrNull();
    }
  }

  Future<List<MedicationBatchTableData>> fetchMedicationBatches({
    int? medicationId,
    DateTime? minExpirationDate,
    int? minRemainingQuantity,
  }) async {
    final query = select(medicationBatchTable);

    if (medicationId != null) {
      query.where((row) => row.medicationId.equals(medicationId));
    }

    if (minExpirationDate != null) {
      query.where((row) => row.expiresAt.isBiggerOrEqualValue(minExpirationDate));
    }

    if (minRemainingQuantity != null) {
      query.where((row) => row.quantity.isBiggerOrEqualValue(minRemainingQuantity));
    }

    return query.get();
  }

  Future<MedicationBatchTableData> fetchMedicationBatch({required int batchId}) {
    return (select(medicationBatchTable)..where((row) => row.id.equals(batchId))).getSingle();
  }

  Future<MedicationBatchTableData> createMedicationBatch({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  }) async {
    final int id = await into(medicationBatchTable).insert(
      MedicationBatchTableCompanion.insert(
        medicationId: medicationId,
        expiresAt: expiresAt,
        initialQuantity: quantity,
        quantity: quantity,
      ),
    );

    return MedicationBatchTableData(
      id: id,
      medicationId: medicationId,
      quantity: quantity,
      initialQuantity: quantity,
      expiresAt: expiresAt,
    );
  }

  Future<void> deleteMedicationBatch({required int batchId}) {
    return (delete(medicationBatchTable)..where((row) => row.id.equals(batchId))).go();
  }

  Future<void> consumeMedication({
    required int batchId,
    required int quantityToConsume,
  }) {
    return (update(medicationBatchTable)..where((row) => row.id.equals(batchId))).write(
      MedicationBatchTableCompanion.custom(
        quantity: medicationBatchTable.quantity - Variable<int>(quantityToConsume),
      ),
    );
  }
}
