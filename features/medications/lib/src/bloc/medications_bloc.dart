import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'medications_event.dart';
part 'medications_state.dart';

class MedicationsBloc extends Bloc<MedicationsEvent, MedicationsState> {
  final AppRouter _appRouter;
  final FetchMedicationsUseCase _fetchMedicationsUseCase;
  final FetchStoredMedicationsUseCase _fetchStoredMedicationsUseCase;

  MedicationsBloc({
    required AppRouter appRouter,
    required FetchMedicationsUseCase fetchMedicationsUseCase,
    required FetchStoredMedicationsUseCase fetchStoredMedicationsUseCase,
  })  : _appRouter = appRouter,
        _fetchMedicationsUseCase = fetchMedicationsUseCase,
        _fetchStoredMedicationsUseCase = fetchStoredMedicationsUseCase,
        super(const MedicationsState.initial()) {
    on<Initialize>(_onInitialize);
    on<AddMedication>(_onAddMedication);
    on<UseMedication>(_onUseMedication);
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<MedicationsState> emit,
  ) async {
    try {
      final List<Medication> medications = await _fetchMedicationsUseCase.execute();
      final List<StoredMedication> stored = await _fetchStoredMedicationsUseCase.execute();

      emit(
        state.copyWith(
          medications: medications.toMap(
            key: (Medication item) => item.id,
            value: (Medication item) => item,
          ),
          storedMedications: stored,
          isLoading: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          hasError: true,
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onAddMedication(
    AddMedication event,
    Emitter<MedicationsState> emit,
  ) async {
    final AddStoredMedicationResult? result = await _appRouter.push(const AddMedicationRoute());

    if (result != null) {
      final Map<int, Medication>? medications = state.medications.containsKey(result.medication.id)
          ? null
          : <int, Medication>{
              ...state.medications,
              result.medication.id: result.medication,
            };

      final List<StoredMedication> storedMedications = <StoredMedication>[
        result.storedMedication,
        ...state.storedMedications,
      ]..sort((StoredMedication a, StoredMedication b) => a.expiresAt.compareTo(b.expiresAt));

      emit(
        state.copyWith(
          medications: medications,
          storedMedications: storedMedications,
        ),
      );
    }
  }

  Future<void> _onUseMedication(
    UseMedication event,
    Emitter<MedicationsState> emit,
  ) async {
    await _appRouter.push(const UseMedicationRoute());
  }
}
