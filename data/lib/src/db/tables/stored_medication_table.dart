part of 'tables.dart';

class StoredMedicationTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get medicationId => integer().references(MedicationTable, #id)();

  IntColumn get quantity => integer()();

  DateTimeColumn get expiresAt => dateTime()();
}
