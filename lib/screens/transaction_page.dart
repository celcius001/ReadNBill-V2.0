import 'package:flutter/material.dart';
import 'package:readnbill/database/database_helper.dart';
import 'package:readnbill/models/rate_model.dart';
import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/screens/printer_settings_page.dart';
import 'package:readnbill/services/billing_calculator.dart';
import 'package:readnbill/services/printer_service.dart';

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

  @override
  void initState() {
    super.initState();

    if (widget.reading.powerReading > 0) {
      presentReadingController.text = widget.reading.powerReading
          .toStringAsFixed(0);

      _calculateUsed();
    }
  }

  Future<void> _saveReading() async {
    final presentReading =
        double.tryParse(presentReadingController.text) ?? 0.0;

    if (presentReading < widget.reading.previousReading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Present reading cannot be less than previous reading.",
          ),
        ),
      );
      return;
    }

    await DatabaseHelper.instance.updateReading(
      accountNumber: widget.reading.accountNumber,
      values: {
        'PowerReadings': presentReading,
        'ReadingDate': DateTime.now().toIso8601String(),
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reading saved successfully.')),
    );
  }

  Future<void> _generateBill() async {
    // Save the reading first
    await _saveReading();

    // Get the rates from the database
    final rate = await DatabaseHelper.instance.getRate(
      widget.reading.consumerType,
    );

    if (rate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No rates found for this consumer type.')),
      );
      return;
    }

    // Calculate the bill based on the rates and kWh used
    final billSummary = BillingCalculator.generateBill(
      rate: rate,
      reading: widget.reading,
      presentReading: widget.reading.powerReading,
    );
    try {
      // Print the bill
      await PrinterService.instance.printBill(billSummary);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bill generated and printed successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to print bill: $e')));
    }
  }

  void _calculateUsed() {
    final presentReading =
        double.tryParse(presentReadingController.text) ?? 0.0;

    setState(() {
      kwhUsed = presentReading - widget.reading.previousReading;

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
                      widget.reading.previousReading.toStringAsFixed(0),
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
                  await _generateBill();
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

// class BillingCalculator {
//   static double generationChange(RateModel rate, double kwhUsed) {
//     return rate.genSysCharge * kwhUsed;
//   }
// }
