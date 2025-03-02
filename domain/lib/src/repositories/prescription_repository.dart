import '../../domain.dart';

abstract interface class PrescriptionRepository {
  Future<List<Prescription>> fetchPrescriptions();

  Future<Prescription> addPrescription({
    required int storedMedicationId,
    required DateTime dateTime,
    required int quantity,
  });

  Future<Prescription> deletePrescription({required int id});
}
