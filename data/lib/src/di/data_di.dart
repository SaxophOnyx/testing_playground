import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class DataDI {
  const DataDI._();

  static void initDependencies(GetIt locator) {
    _initDatabase(locator);
    _initProviders(locator);
    _initRepositories(locator);
  }

  static void _initDatabase(GetIt locator) {
    locator.registerLazySingleton<AppDatabase>(AppDatabase.new);
  }

  static void _initProviders(GetIt locator) {
    locator.registerLazySingleton<MedicationProvider>(
      () => MedicationProviderImpl(
        appDatabase: locator<AppDatabase>(),
      ),
    );

    locator.registerLazySingleton<MedicationBatchProvider>(
      () => MedicationBatchProviderImpl(
        appDatabase: locator<AppDatabase>(),
      ),
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerLazySingleton<MedicationRepository>(
      () => MedicationRepositoryImpl(
        medicationProvider: locator<MedicationProvider>(),
      ),
    );

    locator.registerLazySingleton<MedicationBatchRepository>(
      () => MedicationBatchRepositoryImpl(
        batchProvider: locator<MedicationBatchProvider>(),
      ),
    );
  }
}
