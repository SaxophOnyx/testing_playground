part of 'tables.dart';

class MedicationTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();
}
