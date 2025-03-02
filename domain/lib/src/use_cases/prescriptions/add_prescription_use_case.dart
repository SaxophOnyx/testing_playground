import 'package:core/core.dart';

import '../../../domain.dart';

final class AddPrescriptionPayload {
  final DateTime date;
  final String medicationName;
  final int quantity;

  const AddPrescriptionPayload({
    required this.date,
    required this.medicationName,
    required this.quantity,
  });
}

final class AddPrescriptionUseCase implements FutureUseCase<AddPrescriptionPayload, Prescription> {
  final MedicationRepository _medicationRepository;
  final PrescriptionRepository _prescriptionRepository;

  const AddPrescriptionUseCase({
    required MedicationRepository medicationRepository,
    required PrescriptionRepository prescriptionRepository,
  })  : _medicationRepository = medicationRepository,
        _prescriptionRepository = prescriptionRepository;

  @override
  Future<Prescription> execute(AddPrescriptionPayload payload) async {
    final List<StoredMedication> stored = await _medicationRepository.fetchStoredMedications(
      minExpirationDate: payload.date,
      medicationName: payload.medicationName,
      minQuantity: payload.quantity,
    );

    if (stored.isEmpty) {
      throw const AppException(message: 'Suitable stored medications not found');
    }

    final StoredMedication expiring = stored.reduce(
      (StoredMedication a, StoredMedication b) => a.expiresAt.isBefore(b.expiresAt) ? a : b,
    );

    await _medicationRepository.reserveStoredMedication(
      id: expiring.id,
      quantity: payload.quantity,
    );

    return _prescriptionRepository.addPrescription(
      storedMedicationId: expiring.id,
      dateTime: payload.date,
      quantity: payload.quantity,
    );
  }
}
