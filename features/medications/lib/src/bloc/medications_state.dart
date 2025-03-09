part of 'medications_bloc.dart';

final class MedicationsState {
  final Map<int, Medication> medications;
  final List<StoredMedication> storedMedications;
  final bool isLoading;
  final String error;

  const MedicationsState({
    required this.medications,
    required this.storedMedications,
    required this.isLoading,
    required this.error,
  });

  const MedicationsState.initial()
      : medications = const <int, Medication>{},
        storedMedications = const <StoredMedication>[],
        isLoading = true,
        error = '';

  MedicationsState copyWith({
    Map<int, Medication>? medications,
    List<StoredMedication>? storedMedications,
    bool? isLoading,
    String? hasError,
  }) {
    return MedicationsState(
      medications: medications ?? this.medications,
      storedMedications: storedMedications ?? this.storedMedications,
      isLoading: isLoading ?? this.isLoading,
      error: hasError ?? this.error,
    );
  }
}
