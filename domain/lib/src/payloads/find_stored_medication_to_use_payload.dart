final class FindStoredMedicationToUsePayload {
  final String medicationName;
  final int quantity;
  final DateTime usageDateTime;

  const FindStoredMedicationToUsePayload({
    required this.medicationName,
    required this.quantity,
    required this.usageDateTime,
  });
}
