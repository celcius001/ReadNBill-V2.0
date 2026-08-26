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

      final tempReadings =
          await DatabaseHelper.instance.getPendingTempReadings();

      final readings = await DatabaseHelper.instance.getPendingReadings();

      if (bills.isEmpty && tempReadings.isEmpty && readings.isEmpty) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No bills or tempReadings or readings to upload."),
          ),
        );

        return;
      }

      int uploadedBills = 0;
      int uploadedTempReadings = 0;
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
      if (tempReadings.isNotEmpty) {
        await api.uploadTempReadings(tempReadings);

        final readingIds =
            tempReadings
                .map((tempReading) => tempReading.id)
                .whereType<int>()
                .toList();

        await DatabaseHelper.instance.markTempReadingsAsUploaded(readingIds);

        uploadedTempReadings = tempReadings.length;
      }

      // -------------------------
      // Upload Readings
      // -------------------------
      if (readings.isNotEmpty) {
        await api.uploadReadings(readings);

        final readingIds =
            readings.map((reading) => reading.id).whereType<int>().toList();

        await DatabaseHelper.instance.markReadingsAsUploaded(readingIds);

        uploadedReadings = readings.length;
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Upload successful: "
            "$uploadedBills bill(s), "
            "$uploadedTempReadings tempReading(s), "
            "$uploadedReadings reading(s). ",
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
