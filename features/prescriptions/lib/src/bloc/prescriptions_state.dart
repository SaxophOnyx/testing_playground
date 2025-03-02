part of 'prescriptions_bloc.dart';

final class PrescriptionsState {
  final List<Prescription> prescriptions;
  final Map<int, Medication> medications;
  final Map<int, StoredMedication> storedMedications;
  final bool isLoading;
  final bool hasError;

  const PrescriptionsState({
    required this.prescriptions,
    required this.medications,
    required this.storedMedications,
    required this.isLoading,
    required this.hasError,
  });

  const PrescriptionsState.initial()
      : prescriptions = const <Prescription>[],
        medications = const <int, Medication>{},
        storedMedications = const <int, StoredMedication>{},
        isLoading = true,
        hasError = false;

  PrescriptionsState copyWith({
    List<Prescription>? prescriptions,
    Map<int, Medication>? medications,
    Map<int, StoredMedication>? storedMedications,
    bool? isLoading,
    bool? hasError,
  }) {
    return PrescriptionsState(
      prescriptions: prescriptions ?? this.prescriptions,
      medications: medications ?? this.medications,
      storedMedications: storedMedications ?? this.storedMedications,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
