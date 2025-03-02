import '../../domain.dart';

final class AddStoredMedicationPayload {
  final String medicationName;
  final int quantity;
  final DateTime expiresAt;

  const AddStoredMedicationPayload({
    required this.medicationName,
    required this.quantity,
    required this.expiresAt,
  });
}

final class AddStoredMedicationResult {
  final Medication medication;
  final StoredMedication storedMedication;

  const AddStoredMedicationResult({
    required this.medication,
    required this.storedMedication,
  });
}

final class AddStoredMedicationUseCase
    implements FutureUseCase<AddStoredMedicationPayload, AddStoredMedicationResult> {
  final MedicationRepository _medicationRepository;

  const AddStoredMedicationUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<AddStoredMedicationResult> execute(AddStoredMedicationPayload payload) async {
    final Medication medication = await _medicationRepository.fetchMedication(
      name: payload.medicationName,
      createIfNotFound: true,
    );

    final StoredMedication storedMedication = await _medicationRepository.addStoredMedication(
      medicationId: medication.id,
      quantity: payload.quantity,
      expiresAt: payload.expiresAt,
    );

    return AddStoredMedicationResult(
      medication: medication,
      storedMedication: storedMedication,
    );
  }
}
