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
        super(const UseMedicationState.initial());
}
