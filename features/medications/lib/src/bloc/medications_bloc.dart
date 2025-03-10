import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'medications_event.dart';
part 'medications_state.dart';

class MedicationsBloc extends Bloc<MedicationsEvent, MedicationsState> {
  final AppRouter _appRouter;
  final FetchMedicationsUseCase _fetchMedicationsUseCase;
  final FetchMedicationBatchesUseCase _fetchMedicationBatchesUseCase;
  final DiscardMedicationBatchUseCase _discardMedicationBatchUseCase;

  MedicationsBloc({
    required AppRouter appRouter,
    required FetchMedicationsUseCase fetchMedicationsUseCase,
    required FetchMedicationBatchesUseCase fetchMedicationBatchesUseCase,
    required DiscardMedicationBatchUseCase discardMedicationBatchUseCase,
  })  : _appRouter = appRouter,
        _fetchMedicationsUseCase = fetchMedicationsUseCase,
        _fetchMedicationBatchesUseCase = fetchMedicationBatchesUseCase,
        _discardMedicationBatchUseCase = discardMedicationBatchUseCase,
        super(const MedicationsState.initial()) {
    on<Initialize>(_onInitialize);
    on<AddMedication>(_onAddMedication);
    on<UseMedication>(_onUseMedication);
    on<DeleteMedication>(_onDeleteMedication);
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<MedicationsState> emit,
  ) async {
    try {
      final List<Medication> medications = await _fetchMedicationsUseCase.execute();
      final List<MedicationBatch> batches = await _fetchMedicationBatchesUseCase.execute();

      emit(
        state.copyWith(
          medications: medications.toMap(
            key: (Medication item) => item.id,
            value: (Medication item) => item,
          ),
          batches: batches,
          isLoading: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          error: 'Error while loading medications',
          isLoading: false,
        ),
      );
    }
  }

  Future<void> _onAddMedication(
    AddMedication event,
    Emitter<MedicationsState> emit,
  ) async {
    final AddMedicationBatchResult? result = await _appRouter.push(const AddMedicationRoute());

    if (result != null) {
      final Medication medication = result.medication;

      final Map<int, Medication>? medications = state.medications.containsKey(medication.id)
          ? null
          : <int, Medication>{...state.medications, medication.id: medication};

      final List<MedicationBatch> batches = <MedicationBatch>[
        result.batch,
        ...state.batches,
      ];

      batches.sort(
        (MedicationBatch a, MedicationBatch b) => a.expiresAt.compareTo(b.expiresAt),
      );

      emit(
        state.copyWith(
          medications: medications,
          batches: batches,
        ),
      );
    }
  }

  Future<void> _onUseMedication(
    UseMedication event,
    Emitter<MedicationsState> emit,
  ) async {
    final MedicationBatch? batch = await _appRouter.push<MedicationBatch>(
      const UseMedicationRoute(),
    );
  }

  Future<void> _onDeleteMedication(
    DeleteMedication event,
    Emitter<MedicationsState> emit,
  ) async {}
}
