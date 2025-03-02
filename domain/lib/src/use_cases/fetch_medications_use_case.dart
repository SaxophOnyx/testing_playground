import '../../domain.dart';

final class FetchMedicationsUseCase implements FutureUseCase<void, List<Medication>> {
  final MedicationRepository _medicationRepository;

  const FetchMedicationsUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<List<Medication>> execute([void payload]) {
    return _medicationRepository.fetchMedications();
  }
}
