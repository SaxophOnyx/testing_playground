import '../../domain.dart';

final class AddStoredMedicationPayload {
  final String medicationName;
  final int quantity;
  final DateTime expiresAt;

  AddStoredMedicationPayload({
    required this.medicationName,
    required this.quantity,
    required this.expiresAt,
  });
}

final class AddStoredMedicationUseCase
    implements FutureUseCase<AddStoredMedicationPayload, CreatedStoredMedication> {
  final MedicationRepository _medicationRepository;

  const AddStoredMedicationUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<CreatedStoredMedication> execute(AddStoredMedicationPayload payload) async {
    final Medication medication =
        await _medicationRepository.fetchOrCreateMedication(name: payload.medicationName);

    final StoredMedication storedMedication = await _medicationRepository.addStoredMedication(
      medicationId: medication.id,
      quantity: payload.quantity,
      expiresAt: payload.expiresAt,
    );

    return CreatedStoredMedication(
      storedMedication: storedMedication,
      associatedMedication: medication,
    );
  }
}
