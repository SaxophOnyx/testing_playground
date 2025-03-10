part of 'use_medication_bloc.dart';

class UseMedicationState {
  final String medicationName;
  final int quantity;
  final MedicationBatch? batch;

  final bool didSearchForMedication;

  final String medicationNameError;
  final String quantityError;
  final String operationError;

  bool get hasInputError => !(medicationNameError.isEmpty && quantityError.isEmpty);

  bool get canSearchMedication => !(hasInputError || didSearchForMedication);

  const UseMedicationState({
    required this.medicationName,
    required this.quantity,
    required this.batch,
    required this.didSearchForMedication,
    required this.medicationNameError,
    required this.quantityError,
    required this.operationError,
  });

  const UseMedicationState.initial()
      : medicationName = '',
        quantity = -1,
        batch = null,
        didSearchForMedication = false,
        medicationNameError = '',
        quantityError = '',
        operationError = '';

  UseMedicationState copyWith({
    String? medicationName,
    int? quantity,
    MedicationBatch? Function()? batch,
    bool? didSearchForMedication,
    String? medicationNameError,
    String? quantityError,
    String? operationError,
  }) {
    return UseMedicationState(
      medicationName: medicationName ?? this.medicationName,
      quantity: quantity ?? this.quantity,
      batch: batch != null ? batch.call() : this.batch,
      didSearchForMedication: didSearchForMedication ?? this.didSearchForMedication,
      medicationNameError: medicationNameError ?? this.medicationNameError,
      quantityError: quantityError ?? this.quantityError,
      operationError: operationError ?? this.operationError,
    );
  }
}
