part of 'use_medication_bloc.dart';

sealed class UseMedicationEvent {
  const UseMedicationEvent();
}

class UpdateInput extends UseMedicationEvent {
  final String? medicationName;
  final int? quantity;

  const UpdateInput({
    this.medicationName,
    this.quantity,
  });
}

class SearchForMedication extends UseMedicationEvent {
  const SearchForMedication();
}

class SubmitMedicationUsage extends UseMedicationEvent {
  const SubmitMedicationUsage();
}
