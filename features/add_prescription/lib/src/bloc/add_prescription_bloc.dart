import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:navigation/navigation.dart';

part 'add_prescription_event.dart';
part 'add_prescription_state.dart';

class AddPrescriptionBloc extends Bloc<AddPrescriptionEvent, AddPrescriptionState> {
  final AppRouter _appRouter;
  final AddPrescriptionUseCase _addPrescriptionUseCase;

  AddPrescriptionBloc({
    required AppRouter appRouter,
    required AddPrescriptionUseCase addPrescriptionUseCase,
  })  : _appRouter = appRouter,
        _addPrescriptionUseCase = addPrescriptionUseCase,
        super(const AddPrescriptionState.initial()) {
    on<UpdateInput>(_onUpdateInput);
    on<SubmitInput>(_onSubmitInput);
  }

  void _onUpdateInput(
    UpdateInput event,
    Emitter<AddPrescriptionState> emit,
  ) {
    final String? nameError = event.medicationName != null ? null : state.medicationNameError;
    final String? quantityError = event.quantity != null ? null : state.quantityError;
    final String? dateTimeError = event.dateTime != null ? null : state.dateTimeError;

    emit(
      state.copyWith(
        medicationName: event.medicationName,
        medicationNameError: nameError,
        quantity: event.quantity,
        quantityError: quantityError,
        dateTime: event.dateTime,
        dateTimeError: dateTimeError,
        forceUpdate: true,
      ),
    );
  }

  Future<void> _onSubmitInput(
    SubmitInput event,
    Emitter<AddPrescriptionState> emit,
  ) async {
    final int? quantity = int.tryParse(state.quantity);
    final DateTime? dateTime = DateFormat('dd/MM/yyyy').tryParse(state.dateTime);

    final String? medicationNameError = ValidationService.validateName(state.medicationName);
    final String? quantityError = quantity != null ? null : 'Invalid quantity';
    final String? dateTimeError = ValidationService.validateDate(dateTime);

    emit(
      state.copyWith(
        medicationNameError: medicationNameError,
        quantityError: quantityError,
        dateTimeError: dateTimeError,
        forceUpdate: true,
      ),
    );

    if (!state.hasError) {
      try {
        final Prescription prescription = await _addPrescriptionUseCase.execute(
          AddPrescriptionPayload(
            date: dateTime!,
            medicationName: state.medicationName,
            quantity: quantity!,
          ),
        );

        await _appRouter.maybePop(prescription);
      } catch (_) {
        // TODO(SaxophOnyx): Handle error
      }
    }
  }
}
