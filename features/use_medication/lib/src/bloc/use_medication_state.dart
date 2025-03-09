part of 'use_medication_bloc.dart';

class UseMedicationState {
  final String medicationName;
  final int quantity;
  final StoredMedication? storedMedication;

  final bool didSearchForMedication;

  final String medicationNameError;
  final String quantityError;
  final String operationError;

  bool get hasInputError => !(medicationNameError.isEmpty && quantityError.isEmpty);

  bool get canSearchMedication => !(hasInputError || didSearchForMedication);

  const UseMedicationState({
    required this.medicationName,
    required this.quantity,
    required this.storedMedication,
    required this.didSearchForMedication,
    required this.medicationNameError,
    required this.quantityError,
    required this.operationError,
  });

  const UseMedicationState.initial()
      : medicationName = '',
        quantity = -1,
        storedMedication = null,
        didSearchForMedication = false,
        medicationNameError = '',
        quantityError = '',
        operationError = '';

  UseMedicationState copyWith({
    String? medicationName,
    int? quantity,
    StoredMedication? Function()? storedMedication,
    bool? didSearchForMedication,
    String? medicationNameError,
    String? quantityError,
    String? operationError,
  }) {
    return UseMedicationState(
      medicationName: medicationName ?? this.medicationName,
      quantity: quantity ?? this.quantity,
      storedMedication: storedMedication != null ? storedMedication.call() : this.storedMedication,
      didSearchForMedication: didSearchForMedication ?? this.didSearchForMedication,
      medicationNameError: medicationNameError ?? this.medicationNameError,
      quantityError: quantityError ?? this.quantityError,
      operationError: operationError ?? this.operationError,
    );
  }
}
