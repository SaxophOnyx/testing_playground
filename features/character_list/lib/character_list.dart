library character_list;

import 'package:navigation/navigation.dart';

export 'character_list.gr.dart';

@AutoRouterConfig()
class CharacterListRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(
      initial: true,
      page: CharacterListRoute.page,
    ),
  ];
}
