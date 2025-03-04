part of 'use_medication_bloc.dart';

class UseMedicationState {
  final String medicationName;
  final String medicationNameError;
  final int quantity;
  final String quantityError;
  final String error;
  final bool didFindNothing;
  final int foundMedicationId;

  bool get canSearchMedication =>
      medicationNameError.isEmpty && quantityError.isEmpty && !didFindNothing;

  const UseMedicationState({
    required this.medicationName,
    required this.medicationNameError,
    required this.quantity,
    required this.quantityError,
    required this.error,
    required this.didFindNothing,
    required this.foundMedicationId,
  });

  const UseMedicationState.initial()
      : medicationName = '',
        medicationNameError = '',
        quantity = -1,
        quantityError = '',
        error = '',
        didFindNothing = false,
        foundMedicationId = -1;

  UseMedicationState copyWith({
    String? medicationName,
    String? medicationNameError,
    int? quantity,
    String? quantityError,
    String? error,
    bool? didFindNothing,
    int? foundMedicationId,
  }) {
    return UseMedicationState(
      medicationName: medicationName ?? this.medicationName,
      quantity: quantity ?? this.quantity,
      didFindNothing: didFindNothing ?? this.didFindNothing,
      medicationNameError: medicationNameError ?? this.medicationNameError,
      quantityError: quantityError ?? this.quantityError,
      error: error ?? this.error,
      foundMedicationId: foundMedicationId ?? this.foundMedicationId,
    );
  }
}
