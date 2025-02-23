part of 'add_medication_bloc.dart';

final class AddMedicationState {
  final String name;
  final String? nameError;
  final String quantity;
  final String? quantityError;
  final String expiresAt;
  final String? expiresAtError;

  bool get hasError => nameError != null || quantityError != null || expiresAtError != null;

  const AddMedicationState({
    required this.name,
    required this.nameError,
    required this.quantity,
    required this.quantityError,
    required this.expiresAt,
    required this.expiresAtError,
  });

  const AddMedicationState.initial()
      : name = '',
        nameError = null,
        quantity = '',
        quantityError = null,
        expiresAt = '',
        expiresAtError = null;

  AddMedicationState copyWith({
    String? name,
    String? nameError,
    String? quantity,
    String? quantityError,
    String? expiresAt,
    String? expiresAtError,
    bool forceUpdate = false,
  }) {
    return AddMedicationState(
      name: name ?? this.name,
      nameError: forceUpdate || nameError != null ? nameError : this.nameError,
      quantity: quantity ?? this.quantity,
      quantityError: forceUpdate || quantityError != null ? quantityError : this.quantityError,
      expiresAt: expiresAt ?? this.expiresAt,
      expiresAtError: forceUpdate || expiresAtError != null ? expiresAtError : this.expiresAtError,
    );
  }
}
