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
        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              Expanded(child: child),
              BottomNavigationBar(
                currentIndex: controller.index,
                onTap: controller.animateTo,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.medical_services_outlined),
                    label: 'Medications',
                  ),
                  BottomNavigationBarItem(
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
