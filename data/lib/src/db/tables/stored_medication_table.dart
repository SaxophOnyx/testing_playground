part of 'tables.dart';

class StoredMedicationTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get medicationId => integer().references(MedicationTable, #id)();

  IntColumn get availableQuantity => integer()();

  IntColumn get reservedQuantity => integer()();

  DateTimeColumn get expiresAt => dateTime()();
}
