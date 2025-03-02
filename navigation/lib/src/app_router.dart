import '../navigation.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          initial: true,
          page: MedicationsRoute.page,
        ),
        CustomRoute<void>(
          page: AddMedicationRoute.page,
          durationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
        CustomRoute<void>(
          page: UseMedicationRoute.page,
          durationInMilliseconds: 250,
          transitionsBuilder: TransitionsBuilders.slideLeft,
        ),
      ];
}
