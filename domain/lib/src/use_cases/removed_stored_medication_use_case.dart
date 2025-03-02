import '../../domain.dart';

final class RemoveStoredMedicationUseCase implements FutureUseCase<int, void> {
  final MedicationRepository _medicationRepository;

  const RemoveStoredMedicationUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<void> execute(int storedMedicationId) {
    return _medicationRepository.deleteStoredMedication(id: storedMedicationId);
  }
}
