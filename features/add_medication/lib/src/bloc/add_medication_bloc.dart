import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'add_medication_event.dart';
part 'add_medication_state.dart';

class AddMedicationBloc extends Bloc<AddMedicationEvent, AddMedicationState> {
  final AppRouter _appRouter;
  final AddStoredMedicationUseCase _addStoredMedicationUseCase;

  AddMedicationBloc({
    required AppRouter appRouter,
    required AddStoredMedicationUseCase addStoredMedicationUseCase,
  })  : _appRouter = appRouter,
        _addStoredMedicationUseCase = addStoredMedicationUseCase,
        super(const AddMedicationState.initial()) {
    on<UpdateInput>(_onUpdateInput);
    on<SubmitInput>(_onSubmitInput);
  }

  void _onUpdateInput(
    UpdateInput event,
    Emitter<AddMedicationState> emit,
  ) {
    final String? nameError = event.name != null ? null : state.nameError;
    final String? quantityError = event.quantity != null ? null : state.quantityError;
    final String? expiresAtError = event.expiresAt != null ? null : state.expiresAtError;

    emit(
      state.copyWith(
        name: event.name,
        nameError: nameError,
        quantity: event.quantity,
        quantityError: quantityError,
        expiresAt: event.expiresAt,
        expiresAtError: expiresAtError,
        forceUpdate: true,
      ),
    );
  }

  Future<void> _onSubmitInput(
    SubmitInput event,
    Emitter<AddMedicationState> emit,
  ) async {
    final int? quantity = int.tryParse(state.quantity);
    final DateTime? expiresAt = DateFormat('dd/MM/yyyy').tryParse(state.expiresAt);

    final String? nameError = state.name.isNotEmpty ? null : 'Invalid name';
    final String? quantityError = quantity != null ? null : 'Invalid quantity';
    final String? expiresAtError =
        (expiresAt != null && expiresAt.isAfter(DateTime.now())) ? null : 'Invalid date';

    emit(
      state.copyWith(
        nameError: nameError,
        quantityError: quantityError,
        expiresAtError: expiresAtError,
        forceUpdate: true,
      ),
    );

    if (!state.hasError) {
      try {
        final CreatedStoredMedication medication = await _addStoredMedicationUseCase.execute(
          AddStoredMedicationPayload(
            medicationName: state.name,
            quantity: quantity!,
            expiresAt: expiresAt!,
          ),
        );

        await _appRouter.maybePop(medication);
      } catch (_) {
        // TODO(SaxophOnyx): Handle error
      }
    }
  }
}
