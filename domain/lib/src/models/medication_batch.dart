import 'package:flutter/foundation.dart';

@immutable
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicationBatch &&
        other.id == id &&
        other.medicationId == medicationId &&
        other.quantity == quantity &&
        other.initialQuantity == initialQuantity &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        medicationId.hashCode ^
        quantity.hashCode ^
        initialQuantity.hashCode ^
        expiresAt.hashCode;
  }
}
