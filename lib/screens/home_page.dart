import 'package:flutter/material.dart';
import 'package:readnbill/screens/dashboard_page.dart';
import 'package:readnbill/screens/report_page.dart';
import 'package:readnbill/screens/route_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? _selectedRoute;

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    switch (_selectedIndex) {
      case 0:
        currentScreen = DashboardPage(routeNo: _selectedRoute);
        break;

      case 1:
        currentScreen = RoutePage(
          onRouteSelected: (routeNo) {
            setState(() {
              _selectedRoute = routeNo;
              _selectedIndex = 0; // Go back to Dashboard
            });
          },
        );
        break;

      case 2:
        currentScreen = const ReportPage();
        break;

      default:
        currentScreen = DashboardPage(routeNo: _selectedRoute);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Read & Bill")),
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
