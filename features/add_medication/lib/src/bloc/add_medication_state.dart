part of 'add_medication_bloc.dart';

final class AddMedicationState {
  final String name;
  final String quantity;
  final String expiresAt;

  final String nameError;
  final String quantityError;
  final String expiresAtError;
  final String operationError;

  bool get hasInputError => !(nameError.isEmpty && quantityError.isEmpty && expiresAtError.isEmpty);

  const AddMedicationState({
    required this.name,
    required this.quantity,
    required this.expiresAt,
    required this.nameError,
    required this.quantityError,
    required this.expiresAtError,
    required this.operationError,
  });

  const AddMedicationState.initial()
      : name = '',
        quantity = '',
        expiresAt = '',
        nameError = '',
        quantityError = '',
        expiresAtError = '',
        operationError = '';

  AddMedicationState copyWith({
    String? name,
    String? quantity,
    String? expiresAt,
    String? nameError,
    String? quantityError,
    String? expiresAtError,
    String? operationError,
  }) {
    return AddMedicationState(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      expiresAt: expiresAt ?? this.expiresAt,
      nameError: nameError ?? this.nameError,
      quantityError: quantityError ?? this.quantityError,
      expiresAtError: expiresAtError ?? this.expiresAtError,
      operationError: operationError ?? this.operationError,
    );
  }
}
