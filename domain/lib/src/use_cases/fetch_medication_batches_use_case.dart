import '../../../domain.dart';

final class FetchMedicationBatchesUseCase implements FutureUseCase<void, List<MedicationBatch>> {
  final MedicationBatchRepository _medicationBatchRepository;

  const FetchMedicationBatchesUseCase({
    required MedicationBatchRepository medicationBatchRepository,
  }) : _medicationBatchRepository = medicationBatchRepository;

  @override
  Future<List<MedicationBatch>> execute([void payload]) {
    return _medicationBatchRepository.fetchMedicationBatches();
  }
}
