part of 'add_medication_bloc.dart';

sealed class AddMedicationEvent {
  const AddMedicationEvent();
}

final class UpdateInput extends AddMedicationEvent {
  final String? name;
  final String? quantity;
  final String? expiresAt;

  const UpdateInput({
    this.name,
    this.quantity,
    this.expiresAt,
  });
}

final class SubmitInput extends AddMedicationEvent {
  const SubmitInput();
}
