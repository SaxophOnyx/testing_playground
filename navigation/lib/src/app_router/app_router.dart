import 'package:auto_route/auto_route.dart';
import 'package:character_list/character_list.dart';
import 'package:dashboard/dashboard.dart';
import 'package:favorites/favorites.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          initial: true,
          page: DashboardRoute.page,
          children: <AutoRoute>[
            AutoRoute(
              initial: true,
              page: CharacterListRoute.page,
            ),
            AutoRoute(
              page: FavoritesRoute.page,
            ),
          ],
        ),
      ];
}
