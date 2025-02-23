class StoredMedication {
  final int id;
  final int medicationId;
  final int quantity;
  final DateTime expiresAt;

  const StoredMedication({
    required this.id,
    required this.medicationId,
    required this.quantity,
    required this.expiresAt,
  });
}
