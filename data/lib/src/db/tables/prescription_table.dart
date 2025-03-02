part of 'tables.dart';

class PrescriptionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get prescriptionDateTime => dateTime()();

  IntColumn get storedMedicationId => integer()();

  IntColumn get quantity => integer()();
}
