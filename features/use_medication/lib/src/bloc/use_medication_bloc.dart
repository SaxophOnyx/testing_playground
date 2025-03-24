import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'use_medication_event.dart';
part 'use_medication_state.dart';

class UseMedicationBloc extends Bloc<UseMedicationEvent, UseMedicationState> {
  final AppRouter _appRouter;
  final FindMedicationBatchToConsumeUseCase _findMedicationBatchToConsumeUseCase;
  final ConsumeMedicationBatchUseCase _consumeMedicationBatchUseCase;

  UseMedicationBloc({
    required AppRouter appRouter,
    required FindMedicationBatchToConsumeUseCase findMedicationBatchToConsumeUseCase,
    required ConsumeMedicationBatchUseCase consumeMedicationBatchUseCase,
  })  : _appRouter = appRouter,
        _findMedicationBatchToConsumeUseCase = findMedicationBatchToConsumeUseCase,
        _consumeMedicationBatchUseCase = consumeMedicationBatchUseCase,
        super(const UseMedicationState.initial()) {
    on<UpdateInput>(_onUpdateInput);
    on<SearchForMedication>(_onSearchForMedication);
    on<SubmitMedicationUsage>(_onSubmitMedicationUsage);
  }

  void _onUpdateInput(
    UpdateInput event,
    Emitter<UseMedicationState> emit,
  ) {
    final String nameError = event.medicationName != null ? '' : state.medicationNameError;
    final String quantityError = event.quantity != null ? '' : state.quantityError;

    emit(
      state.copyWith(
        medicationName: event.medicationName,
        medicationNameError: nameError,
        quantity: event.quantity,
        quantityError: quantityError,
        didSearchForMedication: false,
        batch: () => null,
        operationError: '',
      ),
    );
  }

  Future<void> _onSearchForMedication(
    SearchForMedication event,
    Emitter<UseMedicationState> emit,
  ) async {
    try {
      final String nameError = ValidationService.validateName(state.medicationName);
      final String quantityError = ValidationService.validateQuantity(state.quantity);

      emit(
        state.copyWith(
          medicationNameError: nameError,
          quantityError: quantityError,
          operationError: '',
        ),
      );

      if (state.canSearchMedication) {
        emit(
          state.copyWith(batch: () => null),
        );

        final MedicationBatch? batch = await _findMedicationBatchToConsumeUseCase.execute(
          FindMedicationBatchToConsumePayload(
            medicationName: state.medicationName,
            quantityToConsume: state.quantity,
            usageDateTime: DateTime.now(),
          ),
        );

        emit(
          state.copyWith(
            batch: () => batch,
            didSearchForMedication: batch == null,
          ),
        );
      }
    } catch (_) {
      emit(
        state.copyWith(operationError: 'Error while searching for medication'),
      );
    }
  }

  Future<void> _onSubmitMedicationUsage(
    SubmitMedicationUsage event,
    Emitter<UseMedicationState> emit,
  ) async {
    final MedicationBatch? batch = state.batch;

    if (batch != null) {
      emit(
        state.copyWith(operationError: ''),
      );

      try {
        final MedicationBatch updated = await _consumeMedicationBatchUseCase.execute(
          ConsumeMedicationBatchPayload(
            batchId: batch.id,
            quantityToConsume: state.quantity,
          ),
        );

        await _appRouter.maybePop(updated);
      } catch (_) {
        emit(
          state.copyWith(operationError: 'Error while processing medication'),
        );
      }
    }
  }
}
