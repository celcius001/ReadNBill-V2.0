import 'package:flutter/material.dart';
import 'package:readnbill/database/database_helper.dart';
import 'package:readnbill/models/bill_model.dart';
import 'package:readnbill/models/bill_summary.dart';
import 'package:readnbill/models/route_model.dart';
import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/services/billing_calculator.dart';
import 'package:readnbill/services/printer_service.dart';

class TransactionPage extends StatefulWidget {
  final TempModel reading;
  final RouteModel route;

  const TransactionPage({
    super.key,
    required this.reading,
    required this.route,
  });
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

    if (presentReadingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the present reading.')),
      );
      return;
    }

    final presentReading = double.parse(presentReadingController.text);

    // Calculate the bill based on the rates and kWh used
    final billSummary = BillingCalculator.generateBill(
      rate: rate,
      reading: widget.reading,
      route: widget.route,
      previousReading: widget.reading.previousReading,
      presentReading: presentReading,
    );

    /// Route.dueDay is a day-of-month (e.g. 15). Roll to next month if that
    /// day has already passed this month.
    DateTime _computeDueDate(int dueDay, DateTime from) {
      var due = DateTime(from.year, from.month, dueDay);
      if (due.isBefore(from)) {
        due = DateTime(from.year, from.month + 1, dueDay);
      }
      return due;
    }

    BillModel _buildBillModel(
      BillSummary summary,
      TempModel reading,
      RouteModel route,
    ) {
      final now = DateTime.now();
      final dueDate = _computeDueDate(route.dueDay, now);

      return BillModel(
        accountNumber: reading.accountNumber,
        meterNumber: reading.meterNumber,
        consumerType: reading.consumerType,

        powerPreviousReading: reading.previousReading,
        powerPresentReading: summary.presentReading,
        powerKWH: summary.usedKwh,
        additionalKWH: reading.additionalKWH,
        coreLoss: reading.coreloss,

        // Fixed charges carried straight from the reading record
        qcAmount: reading.qcAmount,
        pcAmount: reading.pcAmount,
        epAmount: reading.epAmount,
        bcAmount: reading.bcAmount,

        // Category subtotals from the generated bill
        genSysAmt: summary.generationSubtotal,
        transSysAmt: summary.transmissionSubtotal,
        distribSysAmt: summary.distributionSubtotal,
        // BillModel has separate VAT buckets (Gen/Trans/SL/Dist/Others) but
        // BillSummary only produces one combined vatSubtotal — putting the
        // whole thing under vatOthersAmt for now. Let me know if you want it
        // split by category instead.
        vatOthersAmt: summary.vatSubtotal,
        franchiseTax: summary.govtSubtotal,

        basicAmount: summary.otherSubtotal,
        netAmount: summary.totalAmount,

        servicePeriodEnd: reading.servicePeriodEnd,
        billingDate: now,
        dueDate: dueDate,
      );
    }

    try {
      final billModel = _buildBillModel(
        billSummary,
        widget.reading,
        widget.route,
      );

      // ---- Insert into SQLite ----
      await DatabaseHelper.instance.insertBill(billModel);

      // ---- Print the bill ----
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

  DateTime getDueDate() {
    final servicePeriod = DateTime.parse(widget.reading.servicePeriodEnd);

    return DateTime(
      servicePeriod.year,
      servicePeriod.month + 1,
      widget.route.dueDay,
    );
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
