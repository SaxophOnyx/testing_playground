import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'use_medication_event.dart';
part 'use_medication_state.dart';

class UseMedicationBloc extends Bloc<UseMedicationEvent, UseMedicationState> {
  final AppRouter _appRouter;
  final FindStoredMedicationToUseUseCase _findStoredMedicationToUseUseCase;
  final UseStoredMedicationsUseCase _useStoredMedicationsUseCase;

  UseMedicationBloc({
    required AppRouter appRouter,
    required FindStoredMedicationToUseUseCase findStoredMedicationToUseUseCase,
    required UseStoredMedicationsUseCase useStoredMedicationsUseCase,
  })  : _appRouter = appRouter,
        _findStoredMedicationToUseUseCase = findStoredMedicationToUseUseCase,
        _useStoredMedicationsUseCase = useStoredMedicationsUseCase,
        super(const UseMedicationState.initial()) {
    on<UpdateInput>(_onUpdateInput);
    on<SearchForMedication>(_onSearchForMedication);
    on<SubmitMedicationUsage>(_onSubmitMedicationUsage);
  }

  void _onUpdateInput(
    UpdateInput event,
    Emitter<UseMedicationState> emit,
  ) {
    final String? nameError = event.medicationName != null ? '' : state.medicationNameError;
    final String? quantityError = event.quantity != null ? '' : state.quantityError;

    emit(
      state.copyWith(
        medicationName: event.medicationName,
        medicationNameError: nameError,
        quantity: event.quantity,
        quantityError: quantityError,
        didFindNothing: false,
      ),
    );
  }

  Future<void> _onSearchForMedication(
    SearchForMedication event,
    Emitter<UseMedicationState> emit,
  ) async {
    try {
      final String nameError = ValidationService.validateName(state.medicationName);
      final String quantityError = state.quantity != -1 ? '' : 'Invalid quantity';

      emit(
        state.copyWith(
          medicationNameError: nameError,
          quantityError: quantityError,
        ),
      );

      if (state.canSearchMedication) {
        emit(
          state.copyWith(foundMedicationId: -1),
        );

        final StoredMedication? foundMedication = await _findStoredMedicationToUseUseCase.execute(
          FindStoredMedicationToUsePayload(
            medicationName: state.medicationName,
            quantity: state.quantity,
            usageDateTime: DateTime.now(),
          ),
        );

        emit(
          state.copyWith(
            foundMedicationId: foundMedication?.id ?? -1,
            didFindNothing: foundMedication == null,
          ),
        );
      }
    } catch (_) {
      // TODO(SaxophOnyx): Handle error
    }
  }

  Future<void> _onSubmitMedicationUsage(
    SubmitMedicationUsage event,
    Emitter<UseMedicationState> emit,
  ) async {
    if (state.foundMedicationId != -1) {
      try {
        final StoredMedication updated = await _useStoredMedicationsUseCase.execute(
          UseStoredMedicationsPayload(
            storedMedicationId: state.foundMedicationId,
            quantity: state.quantity,
          ),
        );

        await _appRouter.maybePop(updated);
      } catch (_) {
        // TODO(SaxophOnyx): Handle error
      }
    }
  }
}
