import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final String? routeNo;

  const DashboardPage({super.key, required this.routeNo});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"), centerTitle: true),
      body: Center(child: Text("Route No: ${widget.routeNo}")),
    );
  }
}
