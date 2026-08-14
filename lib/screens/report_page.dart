import 'package:flutter/material.dart';
import 'package:readnbill/database/database_helper.dart';
import 'package:readnbill/services/api_service.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ApiService api = ApiService();

  bool uploading = false;

  Future<void> _uploadAll() async {
    if (uploading) return;

    setState(() {
      uploading = true;
    });

    try {
      // Get pending data
      final bills = await DatabaseHelper.instance.getPendingBills();

      final readings = await DatabaseHelper.instance.getPendingTempReadings();

      if (bills.isEmpty && readings.isEmpty) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No bills or readings to upload.")),
        );

        return;
      }

      int uploadedBills = 0;
      int uploadedReadings = 0;

      // -------------------------
      // Upload Bills
      // -------------------------
      if (bills.isNotEmpty) {
        await api.uploadBills(bills);

        final billIds = bills.map((bill) => bill.id).whereType<int>().toList();

        await DatabaseHelper.instance.markBillsAsUploaded(billIds);

        uploadedBills = bills.length;
      }

      // -------------------------
      // Upload Temp Readings
      // -------------------------
      if (readings.isNotEmpty) {
        await api.uploadTempReadings(readings);

        final readingIds =
            readings.map((reading) => reading.id).whereType<int>().toList();

        await DatabaseHelper.instance.markTempReadingsAsUploaded(readingIds);

        uploadedReadings = readings.length;
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Upload successful: "
            "$uploadedBills bill(s), "
            "$uploadedReadings reading(s).",
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Upload failed: $e")));
    } finally {
      if (mounted) {
        setState(() {
          uploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reports")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: uploading ? null : _uploadAll,
                icon:
                    uploading
                        ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.cloud_upload),
                label: Text(uploading ? "Uploading..." : "Upload All"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
