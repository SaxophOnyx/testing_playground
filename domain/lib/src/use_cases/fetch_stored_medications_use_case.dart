import '../../domain.dart';

final class FetchStoredMedicationsUseCase implements FutureUseCase<void, List<StoredMedication>> {
  final MedicationRepository _medicationRepository;

  const FetchStoredMedicationsUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<List<StoredMedication>> execute([void payload]) {
    return _medicationRepository.fetchStoredMedications();
  }
}
