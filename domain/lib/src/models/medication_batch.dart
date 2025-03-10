class MedicationBatch {
  final int id;
  final int medicationId;
  final int quantity;
  final int initialQuantity;
  final DateTime expiresAt;

  const MedicationBatch({
    required this.id,
    required this.medicationId,
    required this.quantity,
    required this.initialQuantity,
    required this.expiresAt,
  });
}
