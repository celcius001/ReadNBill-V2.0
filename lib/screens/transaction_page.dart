import 'package:flutter/material.dart';
import 'package:readnbill/models/tempreading_model.dart';

class TransactionPage extends StatefulWidget {
  final TempModel reading;

  const TransactionPage({super.key, required this.reading});
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final TextEditingController presentReadingController =
      TextEditingController();

  double kwhUsed = 0.0;

  void _calculateUsed() {
    final presentReading =
        double.tryParse(presentReadingController.text) ?? 0.0;

    setState(() {
      kwhUsed = presentReading - widget.reading.powerReading;

      if (kwhUsed < 0) {
        kwhUsed = 0.0;
      }
    });
  }

  @override
  void dispose() {
    presentReadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.reading.consumerName)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow("Account No.", widget.reading.accountNumber),
                    _infoRow("Meter No.", widget.reading.meterNumber),
                    _infoRow(
                      "Previous Reading",
                      widget.reading.powerReading.toStringAsFixed(0),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text("Used kWh"),
                trailing: Text(
                  kwhUsed.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: presentReadingController,
              keyboardType: TextInputType.number,
              onChanged: (_) => _calculateUsed(),
              decoration: const InputDecoration(
                labelText: "Present Reading",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.print),
                label: const Text("Generate Bill"),
                onPressed: () async {
                  if (presentReadingController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter the present reading."),
                      ),
                    );
                    return;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(value),
      ],
    ),
  );
}
