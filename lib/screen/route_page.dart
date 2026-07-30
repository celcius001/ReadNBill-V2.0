import 'package:flutter/material.dart';
import 'package:readnbill/database/database_helper.dart';

class RoutePage extends StatefulWidget {
  final ValueChanged<String> onRouteSelected;
  const RoutePage({super.key, required this.onRouteSelected});
  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  List<Map<String, dynamic>> _routes = [];

  @override
  void initState() {
    super.initState();
    _loadRoutes();
  }

  Future<void> _loadRoutes() async {
    final routes = await DatabaseHelper.instance.getRoutes();

    if (!mounted) return;

    setState(() {
      _routes = routes;
    });
  }

  void _confirmDelete(String routeNo) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Delete Route"),
            content: Text("Are you sure you want to delete Route $routeNo?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  await DatabaseHelper.instance.deleteRoute(routeNo);

                  if (!mounted) return;

                  Navigator.pop(context);

                  await _loadRoutes();

                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Route $routeNo deleted successfully."),
                    ),
                  );
                },
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }

  void _showAddRouteDialog() {
    final routeController = TextEditingController();
    final seqFromController = TextEditingController();
    final seqToController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Download Route"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: routeController,
                  decoration: const InputDecoration(labelText: "Route"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: seqFromController,
                  decoration: const InputDecoration(labelText: "From"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: seqToController,
                  decoration: const InputDecoration(labelText: "To"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text("Download"),
              onPressed: () async {
                final routeNo = routeController.text.trim();
                final seqFrom = int.parse(seqFromController.text.trim());
                final seqTo = int.parse(seqToController.text.trim());

                await DatabaseHelper.instance.saveRoute(
                  routeNo,
                  seqFrom,
                  seqTo,
                );

                if (!mounted) return;

                await _loadRoutes();

                if (context.mounted) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Route downloaded successfully."),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Routes"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showAddRouteDialog,
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // List of routes
            Expanded(
              child: ListView.builder(
                itemCount: _routes.length,
                itemBuilder: (context, index) {
                  final route = _routes[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.route),
                      title: Text("Route ${route["route_no"]}"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to route details page
                        widget.onRouteSelected(route["route_no"]);
                      },
                      onLongPress: () {
                        _confirmDelete(route["route_no"]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
