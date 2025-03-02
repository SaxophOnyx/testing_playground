import '../../domain.dart';

abstract interface class MedicationRepository {
  Future<List<Medication>> fetchMedications();

  Future<List<StoredMedication>> fetchStoredMedications({
    DateTime? minExpirationDate,
    String? medicationName,
    int? minQuantity,
  });

  Future<Medication> ensureMedicationCreated({required String name});

  Future<StoredMedication> addStoredMedication({
    required int medicationId,
    required int quantity,
    required DateTime expiresAt,
  });

  Future<void> removeStoredMedication({required int id});

  Future<void> reserveStoredMedication({
    required int id,
    required int quantity,
  });

  Future<void> consumeStoredMedication({
    required int id,
    required int quantity,
  });

  Future<void> releaseStoredMedication({
    required int id,
    required int quantity,
  });
}
