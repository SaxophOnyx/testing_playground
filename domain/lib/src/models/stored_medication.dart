class StoredMedication {
  final int id;
  final int medicationId;
  final int quantity;
  final int initialQuantity;
  final DateTime expiresAt;

  const StoredMedication({
    required this.id,
    required this.medicationId,
    required this.quantity,
    required this.initialQuantity,
    required this.expiresAt,
  });
}
