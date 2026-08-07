import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:readnbill/models/bill_summary.dart';
import 'package:readnbill/services/printer_service.dart';

class PrinterSettingsPage extends StatefulWidget {
  const PrinterSettingsPage({super.key});

  @override
  State<PrinterSettingsPage> createState() => _PrinterSettingsPageState();
}

class _PrinterSettingsPageState extends State<PrinterSettingsPage> {
  final service = PrinterService.instance;

  List<BluetoothDevice> devices = [];
  bool connected = false;

  @override
  void initState() {
    super.initState();
    loadPrinters();
  }

  Future<void> loadPrinters() async {
    devices = await service.getBondedDevices();
    connected = await service.isConnected();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> testPrint() async {
    if (!await service.isConnected()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Printer is not connected.")),
      );
      return;
    }

    final printer = service.printer;

    // We'll replace this with actual printing once we verify your API.
    print("Printer Connected!");
    await printer.printCustom("BOHECO II", 3, 1);
    await printer.printCustom("READ & BILL", 2, 1);
    await printer.printNewLine();

    await printer.printLeftRight(
      "Date:",
      DateTime.now().toString().substring(0, 19),
      0,
    );

    await printer.printNewLine();
    await printer.printCustom("TEST PRINT", 2, 1);
    await printer.printNewLine();

    await printer.printLeftRight(
      "Printer",
      service.connectedDevice?.name ?? "Unknown",
      0,
    );

    await printer.printLeftRight("Status", "SUCCESS", 0);
    await printer.printNewLine();

    await printer.printCustom("If you can read this", 1, 1);
    await printer.printCustom("your pritner is working", 1, 1);

    await printer.printNewLine();
    await printer.printNewLine();

    await printer.printCustom("Thank you for using Read & Bill!", 1, 1);
    await printer.printNewLine();
    await printer.printNewLine();
    await printer.paperCut();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Printer is connected.")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Printer Setup")),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: Icon(
                connected
                    ? Icons.bluetooth_connected
                    : Icons.bluetooth_disabled,
                color: connected ? Colors.green : Colors.red,
              ),
              title: Text(connected ? "Connected" : "Not Connected"),
              subtitle: Text(
                service.connectedDevice?.name ?? "No printer selected",
              ),
              trailing: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: loadPrinters,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Paired Printers",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];

                final isCurrent =
                    service.connectedDevice?.address == device.address;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.print),
                    title: Text(device.name ?? "Unknown"),
                    subtitle: Text(device.address ?? ""),

                    trailing:
                        isCurrent
                            ? const Chip(label: Text("Connected"))
                            : ElevatedButton(
                              child: const Text("Connect"),
                              onPressed: () async {
                                final success = await service.connect(device);

                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      success
                                          ? "Connected"
                                          : "Connection Failed",
                                    ),
                                  ),
                                );

                                loadPrinters();
                              },
                            ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.print),
                    label: const Text("Test Print"),
                    onPressed: testPrint,
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.bluetooth_disabled),
                    label: const Text("Disconnect"),
                    onPressed: () async {
                      await service.disconnect();
                      loadPrinters();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
