import '../../domain.dart';

final class DiscardMedicationBatchPayload {
  final int batchId;

  const DiscardMedicationBatchPayload({
    required this.batchId,
  });
}

final class DiscardMedicationBatchUseCase
    implements FutureUseCase<DiscardMedicationBatchPayload, void> {
  final MedicationBatchRepository _medicationBatchRepository;

  const DiscardMedicationBatchUseCase({
    required MedicationBatchRepository medicationBatchRepository,
  }) : _medicationBatchRepository = medicationBatchRepository;

  @override
  Future<void> execute(DiscardMedicationBatchPayload payload) {
    return _medicationBatchRepository.deleteMedicationBatch(batchId: payload.batchId);
  }
}
