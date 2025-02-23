import '../../domain.dart';

final class FetchMedicationsUseCase implements FutureUseCase<void, Map<int, Medication>> {
  final MedicationRepository _medicationRepository;

  const FetchMedicationsUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<Map<int, Medication>> execute([void payload]) {
    return _medicationRepository.fetchMedications();
  }
}
