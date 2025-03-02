import '../../../domain.dart';

final class CancelPrescriptionUseCase implements FutureUseCase<int, void> {
  final MedicationRepository _medicationRepository;
  final PrescriptionRepository _prescriptionRepository;

  const CancelPrescriptionUseCase({
    required MedicationRepository medicationRepository,
    required PrescriptionRepository prescriptionRepository,
  })  : _medicationRepository = medicationRepository,
        _prescriptionRepository = prescriptionRepository;

  @override
  Future<void> execute(int id) async {
    final Prescription prescription = await _prescriptionRepository.deletePrescription(id: id);

    await _medicationRepository.releaseStoredMedication(
      id: prescription.storedMedicationId,
      quantity: prescription.quantity,
    );
  }
}
