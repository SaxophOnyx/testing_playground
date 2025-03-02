part of 'add_prescription_bloc.dart';

final class AddPrescriptionState {
  final String medicationName;
  final String? medicationNameError;
  final String quantity;
  final String? quantityError;
  final String dateTime;
  final String? dateTimeError;
  final bool isLoading;
  final bool hasErrorA;

  bool get hasError =>
      medicationNameError != null || quantityError != null || dateTimeError != null;

  const AddPrescriptionState({
    required this.medicationName,
    required this.medicationNameError,
    required this.quantity,
    required this.quantityError,
    required this.dateTime,
    required this.dateTimeError,
    required this.isLoading,
    required this.hasErrorA,
  });

  const AddPrescriptionState.initial()
      : medicationName = '',
        quantity = '',
        dateTime = '',
        isLoading = true,
        hasErrorA = false,
        medicationNameError = null,
        quantityError = null,
        dateTimeError = null;

  AddPrescriptionState copyWith({
    String? medicationName,
    String? medicationNameError,
    String? quantity,
    String? quantityError,
    String? dateTime,
    String? dateTimeError,
    bool? isLoading,
    bool? hasError,
    bool forceUpdate = false,
  }) {
    return AddPrescriptionState(
      medicationName: medicationName ?? this.medicationName,
      medicationNameError: forceUpdate || medicationNameError != null
          ? medicationNameError
          : this.medicationNameError,
      quantity: quantity ?? this.quantity,
      quantityError: forceUpdate || quantityError != null ? quantityError : this.quantityError,
      dateTime: dateTime ?? this.dateTime,
      dateTimeError: forceUpdate || dateTimeError != null ? dateTimeError : this.dateTimeError,
      isLoading: isLoading ?? this.isLoading,
      hasErrorA: hasError ?? this.hasErrorA,
    );
  }
}
