import 'package:core/core.dart';

import '../../domain.dart';

final class DomainDI {
  const DomainDI._();

  static void initDependencies(GetIt locator) {
    _initUseCases(locator);
  }

  static void _initUseCases(GetIt locator) {
    locator.registerLazySingleton<AddStoredMedicationUseCase>(
      () => AddStoredMedicationUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );

    locator.registerLazySingleton<FetchMedicationsUseCase>(
      () => FetchMedicationsUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );

    locator.registerLazySingleton<FetchStoredMedicationsUseCase>(
      () => FetchStoredMedicationsUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );

    locator.registerLazySingleton<FindStoredMedicationToUseUseCase>(
      () => FindStoredMedicationToUseUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );

    locator.registerLazySingleton<RemoveStoredMedicationUseCase>(
      () => RemoveStoredMedicationUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );

    locator.registerLazySingleton<UseStoredMedicationsUseCase>(
      () => UseStoredMedicationsUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );
  }
}
