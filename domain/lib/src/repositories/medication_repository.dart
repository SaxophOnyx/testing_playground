import '../../domain.dart';

abstract interface class MedicationRepository {
  Future<List<Medication>> fetchMedications();

  Future<Medication?> retrieveMedicationByName({
    required String name,
    required bool createIfNotExist,
  });
}
