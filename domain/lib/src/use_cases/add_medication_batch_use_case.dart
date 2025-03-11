import 'package:core/core.dart';

import '../../domain.dart';

final class AddMedicationBatchPayload {
  final String medicationName;
  final int quantity;
  final DateTime expiresAt;

  const AddMedicationBatchPayload({
    required this.medicationName,
    required this.quantity,
    required this.expiresAt,
  });
}

final class AddMedicationBatchResult {
  final Medication medication;
  final MedicationBatch batch;

  const AddMedicationBatchResult({
    required this.medication,
    required this.batch,
  });
}

final class AddMedicationBatchUseCase
    implements FutureUseCase<AddMedicationBatchPayload, AddMedicationBatchResult> {
  final MedicationRepository _medicationRepository;
  final MedicationBatchRepository _medicationBatchRepository;

  const AddMedicationBatchUseCase({
    required MedicationRepository medicationRepository,
    required MedicationBatchRepository medicationBatchRepository,
  })  : _medicationRepository = medicationRepository,
        _medicationBatchRepository = medicationBatchRepository;

  @override
  Future<AddMedicationBatchResult> execute(AddMedicationBatchPayload payload) async {
    final Medication? medication = await _medicationRepository.searchMedicationByName(
      name: payload.medicationName,
      createIfNotExist: true,
    );

    if (medication == null) {
      throw const AppException.unknown();
    }

    final MedicationBatch batch = await _medicationBatchRepository.createMedicationBatch(
      medicationId: medication.id,
      quantity: payload.quantity,
      expiresAt: payload.expiresAt,
    );

    return AddMedicationBatchResult(
      medication: medication,
      batch: batch,
    );
  }
}
