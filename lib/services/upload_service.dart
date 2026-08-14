import 'package:readnbill/database/database_helper.dart';
import 'package:readnbill/services/api_service.dart';

class UploadService {
  final ApiService api = ApiService();

  Future<void> uploadPendingBills() async {
    final bills = await DatabaseHelper.instance.getPendingBills();

    if (bills.isEmpty) {
      return;
    }

    await api.uploadBills(bills);

    final ids = bills.map((bill) => bill.id).toList();

    await DatabaseHelper.instance.markBillsAsUploaded(
      ids.whereType<int>().toList(),
    );
  }

  Future<void> uploadPendingTempReadings() async {
    final tempReadings = await DatabaseHelper.instance.getPendingTempReadings();

    if (tempReadings.isEmpty) {
      return;
    }

    await api.uploadTempReadings(tempReadings);

    final ids = tempReadings.map((tempReading) => tempReading.id).toList();

    await DatabaseHelper.instance.markBillsAsUploaded(
      ids.whereType<int>().toList(),
    );
  }
}
