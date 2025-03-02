part of 'add_prescription_bloc.dart';

sealed class AddPrescriptionEvent {
  const AddPrescriptionEvent();
}

final class UpdateInput extends AddPrescriptionEvent {
  final String? medicationName;
  final String? quantity;
  final String? dateTime;

  const UpdateInput({
    this.medicationName,
    this.quantity,
    this.dateTime,
  });
}

final class SubmitInput extends AddPrescriptionEvent {
  const SubmitInput();
}
