import '../../core.dart';

final GetIt appLocator = GetIt.instance;

const String unauthScope = 'unauthScope';
const String authScope = 'authScope';

final class AppDI {
  const AppDI._();

  static void initDependencies(GetIt locator, Flavor flavor) {
    locator.registerSingleton<AppConfig>(
      AppConfig.fromFlavor(flavor),
    );
  }
}
