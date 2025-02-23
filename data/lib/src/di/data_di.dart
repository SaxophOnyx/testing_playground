import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class DataDI {
  const DataDI._();

  static void initDependencies(GetIt locator) {
    _initDatabase(locator);
    _initRepositories(locator);
  }

  static void _initDatabase(GetIt locator) {
    locator.registerLazySingleton<AppDatabase>(AppDatabase.new);
  }

  static void _initRepositories(GetIt locator) {
    locator.registerLazySingleton<MedicationRepository>(
      () => MedicationRepositoryImpl(
        appDatabase: locator<AppDatabase>(),
      ),
    );
  }
}
