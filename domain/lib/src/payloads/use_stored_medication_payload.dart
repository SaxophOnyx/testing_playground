final class UseStoredMedicationsPayload {
  final int storedMedicationId;
  final int quantity;

  const UseStoredMedicationsPayload({
    required this.storedMedicationId,
    required this.quantity,
  });
}
