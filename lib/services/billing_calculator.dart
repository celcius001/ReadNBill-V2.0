import 'package:readnbill/models/bill_summary.dart';
import 'package:readnbill/models/rate_model.dart';
import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/services/bill_items.dart';

class BillingCalculator {
  static BillSummary generateBill({
    required TempModel reading,
    required RateModel rate,
    required double presentReading,
  }) {
    final usedKwh =
        (presentReading - reading.previousReading) * reading.multiplier;

    final items = <BillItem>[];

    void addCharge(String description, double rateValue, double quantity) {
      if (rateValue == 0) return;

      items.add(
        BillItem(
          description: description,
          rate: rateValue,
          amount: rateValue * quantity,
        ),
      );
    }

    // Energy Charges
    addCharge("Generation Charge", rate.genSysCharge, usedKwh);

    addCharge("System Loss", rate.sysLossCharge, usedKwh);

    addCharge("Transmission", rate.transSysCharge, usedKwh);

    addCharge("Transmission Adj.", rate.otcaSysCharge, usedKwh);

    addCharge("Distribution", rate.distribSysCharge, usedKwh);

    // Fixed Charges
    addCharge("Supply Charge", rate.supplyRetCusCharge, 1);

    addCharge("Metering Charge", rate.metRetCusCharge, 1);

    // VAT
    addCharge("VAT Generation", rate.vatGen, usedKwh);

    addCharge("VAT Transmission", rate.vatTrans, usedKwh);

    addCharge("VAT Distribution", rate.vatDist, usedKwh);

    // Universal Charges
    addCharge("UC-ME", rate.ucMissElecCharge, usedKwh);

    addCharge("FIT-All", rate.fitAllCharge, usedKwh);

    addCharge("MEREDCI", rate.meredciCharge, usedKwh);

    addCharge("NPCSD", rate.npcsdCharge, usedKwh);

    addCharge("UC-Environmental", rate.ucEnvCharge, usedKwh);

    final total = items.fold(0.0, (sum, item) => sum + item.amount);

    return BillSummary(
      reading: reading,
      usedKwh: usedKwh,
      items: items,
      totalAmount: total,
    );
  }
}
