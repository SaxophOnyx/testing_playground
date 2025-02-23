import '../navigation.dart';

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
              page: MedicationsRoute.page,
            ),
            AutoRoute(
              page: PrescriptionsRoute.page,
            ),
          ],
        ),
        CustomRoute<void>(
          page: AddMedicationRoute.page,
          customRouteBuilder: AppRouteBuilders.dismissibleDialog,
        ),
      ];
}
