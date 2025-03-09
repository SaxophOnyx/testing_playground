final class AddStoredMedicationPayload {
  final String medicationName;
  final int quantity;
  final DateTime expiresAt;

  const AddStoredMedicationPayload({
    required this.medicationName,
    required this.quantity,
    required this.expiresAt,
  });
}
