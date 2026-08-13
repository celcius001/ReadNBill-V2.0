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
}
