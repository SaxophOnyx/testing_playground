import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  late AppDatabase database;
  late MedicationProviderImpl provider;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    provider = MedicationProviderImpl(appDatabase: database);
  });

  tearDown(() async => database.close());

  group('fetchMedications', () {
    test('returns an empty list when no medications exist', () async {
      final List<MedicationTableData> medications = await provider.fetchMedications();
      expect(medications, isEmpty);
    });

    test('returns the correct list of medications', () async {
      await database
          .into(database.medicationTable)
          .insert(MedicationTableCompanion.insert(name: 'Name 1'));

      await database
          .into(database.medicationTable)
          .insert(MedicationTableCompanion.insert(name: 'Name 2'));

      final List<MedicationTableData> medications = await provider.fetchMedications();

      expect(medications.length, 2);
      expect(medications.map((MedicationTableData m) => m.name), contains('Name 1'));
      expect(medications.map((MedicationTableData m) => m.name), contains('Name 2'));
    });
  });

  group('searchMedicationByName', () {
    test('returns the medication with given name', () async {
      await database
          .into(database.medicationTable)
          .insert(MedicationTableCompanion.insert(name: 'Name'));

      final MedicationTableData? medication = await provider.searchMedicationByName(name: 'Name');

      expect(medication?.name, 'Name');
    });

    test('returns null for non-existing medication with given name', () async {
      final MedicationTableData? medication = await provider.searchMedicationByName(name: 'Name');
      expect(medication, matcher.isNull);
    });
  });

  group('searchOrCreateMedicationByName', () {
    test('returns existing medication with given name without creating new one', () async {
      await database
          .into(database.medicationTable)
          .insert(MedicationTableCompanion.insert(name: 'Name'));

      final MedicationTableData medication = await provider.searchOrCreateMedicationByName(
        name: 'Name',
      );

      final int totalRows = await database
          .select(database.medicationTable)
          .get()
          .then((List<MedicationTableData> list) => list.length);

      expect(medication.name, 'Name');
      expect(totalRows, 1);
    });

    test('creates new medication with given name and return it', () async {
      final MedicationTableData medication = await provider.searchOrCreateMedicationByName(
        name: 'Name',
      );

      final List<MedicationTableData> rows = await database.select(database.medicationTable).get();
      final MedicationTableData created = rows.first;

      expect(medication.name, 'Name');
      expect(created, medication);
      expect(rows.length, 1);
    });
  });
}
