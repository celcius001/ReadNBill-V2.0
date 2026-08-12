import 'package:flutter/material.dart';
import 'package:readnbill/models/route_model.dart';
import 'package:readnbill/screens/dashboard_page.dart';
import 'package:readnbill/screens/printer_settings_page.dart';
import 'package:readnbill/screens/report_page.dart';
import 'package:readnbill/screens/route_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  RouteModel? _selectedRoute;

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    switch (_selectedIndex) {
      case 0:
        currentScreen = DashboardPage(route: _selectedRoute);
        break;

      case 1:
        currentScreen = RoutePage(
          onRouteSelected: (route) {
            setState(() {
              _selectedRoute = route;
              _selectedIndex = 0; // Go back to Dashboard
            });
          },
        );
        break;

      case 2:
        currentScreen = const ReportPage();
        break;

      default:
        currentScreen = DashboardPage(route: _selectedRoute);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Read & Bill"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'printer':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrinterSettingsPage(),
                    ),
                  );
                  break;

                case 'about':
                  showAboutDialog(
                    context: context,
                    applicationName: 'Read & Bill',
                    applicationVersion: '1.0.0',
                  );
                  break;
              }
            },
            itemBuilder:
                (context) => const [
                  PopupMenuItem(
                    value: 'printer',
                    child: Row(
                      children: [
                        Icon(Icons.print),
                        SizedBox(width: 10),
                        Text('Printer Setup'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'about',
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 10),
                        Text('About'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reports'),
        ],
      ),
    );
  }
}
