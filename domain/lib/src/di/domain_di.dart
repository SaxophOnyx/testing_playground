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

    locator.registerLazySingleton<RemoveStoredMedicationUseCase>(
      () => RemoveStoredMedicationUseCase(
        medicationRepository: locator<MedicationRepository>(),
      ),
    );

    locator.registerLazySingleton<AddPrescriptionUseCase>(
      () => AddPrescriptionUseCase(
        medicationRepository: locator<MedicationRepository>(),
        prescriptionRepository: locator<PrescriptionRepository>(),
      ),
    );

    locator.registerLazySingleton<CancelPrescriptionUseCase>(
      () => CancelPrescriptionUseCase(
        medicationRepository: locator<MedicationRepository>(),
        prescriptionRepository: locator<PrescriptionRepository>(),
      ),
    );

    locator.registerLazySingleton<ConfirmPrescriptionUseCase>(
      () => ConfirmPrescriptionUseCase(
        medicationRepository: locator<MedicationRepository>(),
        prescriptionRepository: locator<PrescriptionRepository>(),
      ),
    );

    locator.registerLazySingleton<FetchPrescriptionsUseCase>(
      () => FetchPrescriptionsUseCase(
        prescriptionRepository: locator<PrescriptionRepository>(),
      ),
    );
  }
}
