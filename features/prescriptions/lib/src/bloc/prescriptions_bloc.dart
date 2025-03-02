import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'prescriptions_event.dart';
part 'prescriptions_state.dart';

class PrescriptionsBloc extends Bloc<PrescriptionsEvent, PrescriptionsState> {
  final AppRouter _appRouter;
  final FetchMedicationsUseCase _fetchMedicationsUseCase;
  final FetchStoredMedicationsUseCase _fetchStoredMedicationsUseCase;
  final FetchPrescriptionsUseCase _fetchPrescriptionsUseCase;

  PrescriptionsBloc({
    required AppRouter appRouter,
    required FetchMedicationsUseCase fetchMedicationsUseCase,
    required FetchStoredMedicationsUseCase fetchStoredMedicationsUseCase,
    required FetchPrescriptionsUseCase fetchPrescriptionsUseCase,
  })  : _appRouter = appRouter,
        _fetchMedicationsUseCase = fetchMedicationsUseCase,
        _fetchStoredMedicationsUseCase = fetchStoredMedicationsUseCase,
        _fetchPrescriptionsUseCase = fetchPrescriptionsUseCase,
        super(const PrescriptionsState.initial()) {
    on<Initialize>(_onInitialize);
    on<AddPrescription>(_onAddPrescription);
  }

  Future<void> _onInitialize(
    Initialize event,
    Emitter<PrescriptionsState> emit,
  ) async {
    try {
      final List<Medication> medications = await _fetchMedicationsUseCase.execute();
      final List<StoredMedication> stored = await _fetchStoredMedicationsUseCase.execute();
      final List<Prescription> prescriptions = await _fetchPrescriptionsUseCase.execute();

      emit(
        state.copyWith(
          prescriptions: prescriptions,
          medications: medications.toMap(
            key: (Medication item) => item.id,
            value: (Medication item) => item,
          ),
          storedMedications: stored.toMap(
            key: (StoredMedication item) => item.id,
            value: (StoredMedication item) => item,
          ),
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

  Future<void> _onAddPrescription(
    AddPrescription event,
    Emitter<PrescriptionsState> emit,
  ) async {
    final Prescription? prescription = await _appRouter.push(const AddPrescriptionRoute());
    if (prescription != null) {}
  }
}
