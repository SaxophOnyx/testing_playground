import '../../domain.dart';

abstract interface class MedicationRepository {
  Future<StoredMedication> addStoredMedication({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  });

  Future<Map<int, Medication>> fetchMedications();

  Future<List<StoredMedication>> fetchStoredMedications();

  Future<Medication> fetchOrCreateMedication({required String name});
}
