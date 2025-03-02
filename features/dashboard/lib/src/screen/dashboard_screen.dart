import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      physics: const NeverScrollableScrollPhysics(),
      builder: (BuildContext context, Widget child, TabController controller) {
        final Color background = Theme.of(context).scaffoldBackgroundColor;

        return ColoredBox(
          color: background,
          child: Column(
            children: <Widget>[
              Expanded(child: child),
              NavigationBar(
                height: 42,
                selectedIndex: controller.index,
                onDestinationSelected: controller.animateTo,
                backgroundColor: background,
                destinations: const <NavigationDestination>[
                  NavigationDestination(
                    icon: Icon(Icons.medical_services_outlined),
                    label: 'Medications',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.calendar_month_outlined),
                    label: 'Prescriptions',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
