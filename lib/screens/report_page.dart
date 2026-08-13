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

  Future<void> _uploadBills() async {
    if (uploading) return;

    setState(() {
      uploading = true;
    });

    try {
      // Get bills that haven't been uploaded yet
      final bills = await DatabaseHelper.instance.getPendingBills();

      if (bills.isEmpty) {
        if (!mounted) return;

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("No bills to upload.")));

        return;
      }

      // Upload all pending bills
      await api.uploadBills(bills);

      // Mark them as uploaded
      final ids = bills.map((bill) => bill.id).toList();

      await DatabaseHelper.instance.markBillsAsUploaded(
        ids.whereType<int>().toList(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${bills.length} bill(s) uploaded successfully."),
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
                onPressed: uploading ? null : _uploadBills,
                icon:
                    uploading
                        ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.cloud_upload),
                label: Text(uploading ? "Uploading..." : "Upload Bills"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
