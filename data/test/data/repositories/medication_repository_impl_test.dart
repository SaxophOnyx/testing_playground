import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

import 'fakes/fake_medication_provider.dart';

void main() {
  late FakeMedicationProvider fakeMedicationProvider;
  late MedicationRepositoryImpl medicationRepository;

  setUp(() {
    fakeMedicationProvider = FakeMedicationProvider();
    medicationRepository = MedicationRepositoryImpl(medicationProvider: fakeMedicationProvider);
  });

  group('fetchMedications', () {
    test('successfully fetches medications', () async {
      fakeMedicationProvider.medications.addAll(
        const <MedicationTableData>[
          MedicationTableData(id: 1, name: 'Name 1'),
          MedicationTableData(id: 2, name: 'Name 2'),
        ],
      );

      final List<Medication> medications = await medicationRepository.fetchMedications();

      expect(medications.length, 2);
      expect(medications[0].name, 'Name 1');
      expect(medications[1].name, 'Name 2');
    });

    test('returns an empty list when no medications are available', () async {
      final List<Medication> medications = await medicationRepository.fetchMedications();
      expect(medications, isEmpty);
    });
  });

  group('retrieveMedicationByName', () {
    test('successfully retrieves existing medication without creating a new one', () async {
      fakeMedicationProvider.medications.add(const MedicationTableData(id: 1, name: 'Name'));

      final Medication? retrievedMedication = await medicationRepository.retrieveMedicationByName(
        name: 'Name',
        createIfNotExist: false,
      );

      expect(retrievedMedication, matcher.isNotNull);
      expect(retrievedMedication!.name, 'Name');
      expect(fakeMedicationProvider.medications.length, 1);
    });

    test('creates medication if it does not exist', () async {
      final Medication? retrievedMedication = await medicationRepository.retrieveMedicationByName(
        name: 'Name',
        createIfNotExist: true,
      );

      expect(retrievedMedication, matcher.isNotNull);
      expect(retrievedMedication!.name, 'Name');
      expect(fakeMedicationProvider.medications.length, 1);
    });

    test('returns null if medication does not exist and createIfNotExist is false', () async {
      final Medication? retrievedMedication = await medicationRepository.retrieveMedicationByName(
        name: 'Med3',
        createIfNotExist: false,
      );

      expect(retrievedMedication, matcher.isNull);
    });
  });
}
