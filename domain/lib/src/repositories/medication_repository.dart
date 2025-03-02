import '../../domain.dart';

abstract interface class MedicationRepository {
  Future<List<Medication>> fetchMedications();

  Future<List<StoredMedication>> fetchStoredMedications({
    DateTime? minExpirationDate,
    int? medicationId,
    int? minQuantity,
  });

  Future<Medication> fetchMedication({
    required String name,
    required bool createIfNotFound,
  });

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
