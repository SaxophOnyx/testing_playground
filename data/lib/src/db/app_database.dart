import 'dart:io';

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
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

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
}
