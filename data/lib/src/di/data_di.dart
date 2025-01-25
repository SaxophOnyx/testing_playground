import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class DataDI {
  const DataDI._();

  static void initDependencies(GetIt locator) {
    _initApi(locator);
    _initProviders(locator);
    _initRepositories(locator);
  }

  static void _initApi(GetIt locator) {
    locator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        dio: Dio(
          BaseOptions(
            baseUrl: locator<AppConfig>().baseUrl,
          ),
        ),
        listResultField: ApiConstants.listResponseField,
      ),
    );
  }

  static void _initProviders(GetIt locator) {}

  static void _initRepositories(GetIt locator) {}
}
