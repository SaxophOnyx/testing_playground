class StoredMedication {
  final int id;
  final int medicationId;
  final int availableQuantity;
  final int reservedQuantity;
  final DateTime expiresAt;

  const StoredMedication({
    required this.id,
    required this.medicationId,
    required this.availableQuantity,
    required this.reservedQuantity,
    required this.expiresAt,
  });
}
