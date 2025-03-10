part of 'medications_bloc.dart';

final class MedicationsState {
  final Map<int, Medication> medications;
  final List<MedicationBatch> batches;
  final bool isLoading;
  final String error;

  const MedicationsState({
    required this.medications,
    required this.batches,
    required this.isLoading,
    required this.error,
  });

  const MedicationsState.initial()
      : medications = const <int, Medication>{},
        batches = const <MedicationBatch>[],
        isLoading = true,
        error = '';

  MedicationsState copyWith({
    Map<int, Medication>? medications,
    List<MedicationBatch>? batches,
    bool? isLoading,
    String? error,
  }) {
    return MedicationsState(
      medications: medications ?? this.medications,
      batches: batches ?? this.batches,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
