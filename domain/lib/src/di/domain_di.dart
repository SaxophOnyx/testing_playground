import 'package:core/core.dart';

import '../../domain.dart';

final class DomainDI {
  const DomainDI._();

  static void initDependencies(GetIt locator) {
    _initUseCases(locator);
  }

  static void _initUseCases(GetIt locator) {
    locator.registerLazySingleton<AddMedicationBatchUseCase>(
      () => AddMedicationBatchUseCase(
        medicationRepository: locator<MedicationRepository>(),
        medicationBatchRepository: locator<MedicationBatchRepository>(),
      ),
    );

    locator.registerLazySingleton<FetchMedicationsUseCase>(
      () => FetchMedicationsUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );

    locator.registerLazySingleton<FetchMedicationBatchesUseCase>(
      () => FetchMedicationBatchesUseCase(
        medicationBatchRepository: locator<MedicationBatchRepository>(),
      ),
    );

    locator.registerLazySingleton<FindMedicationBatchToConsumeUseCase>(
      () => FindMedicationBatchToConsumeUseCase(
        medicationRepository: locator<MedicationRepository>(),
        medicationBatchRepository: locator<MedicationBatchRepository>(),
      ),
    );

    locator.registerLazySingleton<DiscardMedicationBatchUseCase>(
      () => DiscardMedicationBatchUseCase(
        medicationBatchRepository: locator<MedicationBatchRepository>(),
      ),
    );

    locator.registerLazySingleton<ConsumeMedicationBatchUseCase>(
      () => ConsumeMedicationBatchUseCase(
        medicationBatchRepository: locator<MedicationBatchRepository>(),
      ),
    );
  }
}
