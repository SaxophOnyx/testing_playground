import '../../domain.dart';

final class FindMedicationBatchToConsumePayload {
  final String medicationName;
  final int quantityToConsume;
  final DateTime usageDateTime;

  const FindMedicationBatchToConsumePayload({
    required this.medicationName,
    required this.quantityToConsume,
    required this.usageDateTime,
  });
}

final class FindMedicationBatchToConsumeUseCase
    implements FutureUseCase<FindMedicationBatchToConsumePayload, MedicationBatch?> {
  final MedicationRepository _medicationRepository;
  final MedicationBatchRepository _medicationBatchRepository;

  const FindMedicationBatchToConsumeUseCase({
    required MedicationRepository medicationRepository,
    required MedicationBatchRepository medicationBatchRepository,
  })  : _medicationRepository = medicationRepository,
        _medicationBatchRepository = medicationBatchRepository;

  @override
  Future<MedicationBatch?> execute(FindMedicationBatchToConsumePayload payload) async {
    final Medication? medication = await _medicationRepository.searchMedicationByName(
      name: payload.medicationName,
    );

    if (medication != null) {
      final List<MedicationBatch> batches = await _medicationBatchRepository.fetchMedicationBatches(
        medicationId: medication.id,
        minRemainingQuantity: payload.quantityToConsume,
        minExpirationDate: payload.usageDateTime,
      );

      if (batches.isNotEmpty) {
        return batches.reduce(
          (MedicationBatch a, MedicationBatch b) => a.expiresAt.isBefore(b.expiresAt) ? a : b,
        );
      }
    }

    return null;
  }
}
