import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/services/bill_items.dart';

class BillSummary {
  final TempModel reading;
  final double usedKwh;
  final List<BillItem> items;
  final double totalAmount;

  const BillSummary({
    required this.reading,
    required this.usedKwh,
    required this.items,
    required this.totalAmount,
  });
}
