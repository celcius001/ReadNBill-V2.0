import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/services/bill_items.dart';

class BillSummary {
  final TempModel reading;
  final double presentReading;
  final double usedKwh;
  final List<BillItem> items;

  final List<BillItem> generationItems;
  final List<BillItem> transmissionItems;
  final List<BillItem> distributionItems;
  final double generationSubtotal;
  final double transmissionSubtotal;
  final double distributionSubtotal;

  final double totalAmount;

  const BillSummary({
    required this.reading,
    required this.presentReading,
    required this.usedKwh,
    required this.items,
    required this.generationItems,
    required this.generationSubtotal,
    required this.transmissionItems,
    required this.transmissionSubtotal,
    required this.distributionItems,
    required this.distributionSubtotal,
    required this.totalAmount,
  });
}
