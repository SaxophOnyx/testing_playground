import '../../../domain.dart';

final class UseStoredMedicationsPayload {
  final int storedMedicationId;
  final int quantity;

  const UseStoredMedicationsPayload({
    required this.storedMedicationId,
    required this.quantity,
  });
}

final class UseStoredMedicationsUseCase
    implements FutureUseCase<UseStoredMedicationsPayload, StoredMedication> {
  final MedicationRepository _medicationRepository;

  const UseStoredMedicationsUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<StoredMedication> execute(UseStoredMedicationsPayload payload) {
    return _medicationRepository.adjustStoredMedicationQuantity(
      storedMedicationId: payload.storedMedicationId,
      quantityChange: payload.quantity,
    );
  }
}
