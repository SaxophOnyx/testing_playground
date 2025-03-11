import '../../../domain.dart';

final class ConsumeMedicationBatchPayload {
  final int batchId;
  final int quantityToConsume;

  const ConsumeMedicationBatchPayload({
    required this.batchId,
    required this.quantityToConsume,
  });
}

final class ConsumeMedicationBatchUseCase
    implements FutureUseCase<ConsumeMedicationBatchPayload, MedicationBatch> {
  final MedicationBatchRepository _medicationBatchRepository;

  const ConsumeMedicationBatchUseCase({
    required MedicationBatchRepository medicationBatchRepository,
  }) : _medicationBatchRepository = medicationBatchRepository;

  @override
  Future<MedicationBatch> execute(ConsumeMedicationBatchPayload payload) {
    return _medicationBatchRepository.consumeMedication(
      batchId: payload.batchId,
      quantityToConsume: payload.quantityToConsume,
    );
  }
}
