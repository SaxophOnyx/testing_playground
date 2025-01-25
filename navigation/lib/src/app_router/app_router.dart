import 'package:auto_route/auto_route.dart';
import 'package:character_list/character_list.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        ...CharacterListRouter().routes,
      ];
}