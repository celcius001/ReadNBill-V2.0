import 'package:readnbill/models/route_model.dart';
import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/services/bill_items.dart';

class BillSummary {
  final TempReadingModel reading;
  final RouteModel route;
  final double presentReading;
  final double usedKwh;
  final List<BillItem> items;

  final List<BillItem> generationItems;
  final List<BillItem> transmissionItems;
  final List<BillItem> distributionItems;
  final List<BillItem> otherItems;
  final List<BillItem> vatItems;
  final List<BillItem> govtItems;
  final List<BillItem> vatSaleItems;
  final List<BillItem> vatZeroItems;
  final double generationSubtotal;
  final double transmissionSubtotal;
  final double distributionSubtotal;
  final double otherSubtotal;
  final double vatSubtotal;
  final double govtSubtotal;
  final double vatSaleSubtotal;
  final double vatZeroSubtotal;
  final double totalAmount;

  const BillSummary({
    required this.reading,
    required this.route,
    required this.presentReading,
    required this.usedKwh,
    required this.items,
    required this.generationItems,
    required this.generationSubtotal,
    required this.transmissionItems,
    required this.transmissionSubtotal,
    required this.distributionItems,
    required this.distributionSubtotal,
    required this.otherItems,
    required this.otherSubtotal,
    required this.vatItems,
    required this.vatSubtotal,
    required this.govtItems,
    required this.govtSubtotal,
    required this.vatSaleItems,
    required this.vatSaleSubtotal,
    required this.vatZeroItems,
    required this.vatZeroSubtotal,
    required this.totalAmount,
  });
}
