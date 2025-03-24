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
          customRouteBuilder: AppRouterBuilders.scrollableBottomSheet,
        ),
        CustomRoute<void>(
          page: UseMedicationRoute.page,
          customRouteBuilder: AppRouterBuilders.scrollableBottomSheet,
        ),
      ];
}
