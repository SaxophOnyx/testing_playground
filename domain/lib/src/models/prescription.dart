final class Prescription {
  final int id;
  final DateTime dateTime;
  final int storedMedicationId;
  final int quantity;

  const Prescription({
    required this.id,
    required this.dateTime,
    required this.storedMedicationId,
    required this.quantity,
  });
}
