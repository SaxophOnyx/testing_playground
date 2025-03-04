import '../../domain.dart';

abstract interface class MedicationRepository {
  Future<List<Medication>> fetchMedications();

  Future<List<StoredMedication>> fetchStoredMedications({
    DateTime? minExpirationDate,
    int? medicationId,
    int? minQuantity,
  });

  Future<Medication> fetchOrCreateMedication({required String name});

  Future<Medication?> searchMedication({required String name});

  Future<StoredMedication> addStoredMedication({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  });

  Future<void> deleteStoredMedication({required int id});

  Future<StoredMedication> adjustStoredMedicationQuantity({
    required int storedMedicationId,
    required int quantityChange,
  });
}
