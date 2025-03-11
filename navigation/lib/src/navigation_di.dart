import 'package:core/core.dart';

import 'app_router.dart';

final class NavigationDI {
  const NavigationDI._();

  static void initDependencies(GetIt locator) {
    locator.registerSingleton(AppRouter());
  }
}
