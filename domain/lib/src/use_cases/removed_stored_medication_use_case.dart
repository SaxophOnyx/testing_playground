import '../../domain.dart';

final class RemoveStoredMedicationUseCase
    implements FutureUseCase<RemoveStoredMedicationPayload, void> {
  final MedicationRepository _medicationRepository;

  const RemoveStoredMedicationUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<void> execute(RemoveStoredMedicationPayload payload) {
    return _medicationRepository.deleteStoredMedication(id: payload.storedMedicationId);
  }
}
