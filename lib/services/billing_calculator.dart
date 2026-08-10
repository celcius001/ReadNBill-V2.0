import 'package:readnbill/models/bill_summary.dart';
import 'package:readnbill/models/rate_model.dart';
import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/services/bill_items.dart';

class BillingCalculator {
  static BillSummary generateBill({
    required RateModel rate,
    required TempModel reading,
    required double previousReading,
    required double presentReading,
  }) {
    final usedKwh = (presentReading - previousReading);

    final items = <BillItem>[];

    void addCharge(String description, double? rateValue, double quantity) {
      if (rateValue == null || rateValue <= 0) return;

      items.add(
        BillItem(
          description: description,
          rate: rateValue,
          amount: rateValue * quantity,
        ),
      );
    }

    // GENERATION
    addCharge("GenSys", rate.genSysCharge, usedKwh);
    addCharge("Oga", rate.ogaCharge, usedKwh);
    addCharge("OgaCurr", rate.ogaCurrCharge, usedKwh);
    addCharge("Oga3Curr", rate.oga3Charge, usedKwh);
    addCharge("Psalm", rate.fbhcCharge, usedKwh);
    addCharge("SysLoss", rate.sysLossCharge, usedKwh);
    addCharge("Osla", rate.oslaCharge, usedKwh);
    addCharge("OslaCurr", rate.oslaCurrCharge, usedKwh);
    addCharge("Osla3Curr", rate.osla3Charge, usedKwh);
    addCharge("VATGen", rate.vatGen, usedKwh);
    addCharge("VATSL", rate.vatSL, usedKwh);

    // TRANSMISSION
    addCharge("OtcaDem", rate.otcaDemCharge, usedKwh);
    addCharge("OtcaDemCurr", rate.otcaDemCurrCharge, usedKwh);
    addCharge("OtcaDem3Curr", rate.otcaDem3Charge, usedKwh);
    addCharge("TransSysCharge", rate.transSysCharge, usedKwh);
    addCharge("AncSvcsCharge", rate.otcaSysCharge, usedKwh);
    addCharge("OtcaSysCurr", rate.otcaSysCurrCharge, usedKwh);
    addCharge("Otca3SysCurr", rate.otcaSys3Charge, usedKwh);
    addCharge("VATTrans", rate.vatTrans, usedKwh);

    // DISTRIBUTION
    addCharge("DistDemCharge", rate.distribDemCharge, usedKwh);
    addCharge("DistSysCharge", rate.distribSysCharge, usedKwh);
    addCharge("SupRetCharge", rate.supplyRetCusCharge, 1);
    addCharge("SupSysCharge", rate.supplySysCharge, usedKwh);
    addCharge("MetRetCharge", rate.metRetCusCharge, 1);
    addCharge("MetSysCharge", rate.metSysCharge, usedKwh);
    addCharge("PAR", rate.par, usedKwh);
    addCharge("RFSC", rate.loanCondonation, usedKwh);

    // Fixed Charges
    addCharge("Supply Charge", rate.supplyRetCusCharge, 1);

    addCharge("Metering Charge", rate.metRetCusCharge, 1);

    // VAT

    addCharge("VATDist", rate.vatDist, usedKwh);

    // Universal Charges
    addCharge("UC-ME", rate.ucMissElecCharge, usedKwh);

    addCharge("FIT-All", rate.fitAllCharge, usedKwh);

    addCharge("MEREDCI", rate.meredciCharge, usedKwh);

    addCharge("NPCSD", rate.npcsdCharge, usedKwh);

    addCharge("UC-Environmental", rate.ucEnvCharge, usedKwh);

    // Calculate substotal
    final generationItems =
        items
            .where(
              (item) =>
                  item.description == "GenSys" ||
                  item.description == "Oga" ||
                  item.description == "OgaCurr" ||
                  item.description == "Oga3Curr" ||
                  item.description == "Psalm" ||
                  item.description == "SysLoss" ||
                  item.description == "Osla" ||
                  item.description == "OslaCurr" ||
                  item.description == "Osla3Curr" ||
                  item.description == "VATGen" ||
                  item.description == "VATSL",
            )
            .toList();
    final generationSubtotal = generationItems.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final transmissionItems =
        items
            .where(
              (item) =>
                  item.description == "OtcaDem" ||
                  item.description == "OtcaDemCurr" ||
                  item.description == "OtcaDem3Curr" ||
                  item.description == "TransSysCharge" ||
                  item.description == "AncSvcsCharge" ||
                  item.description == "OtcaSysCurr" ||
                  item.description == "Otca3SysCurr" ||
                  item.description == "VATTrans",
            )
            .toList();
    final transmissionSubtotal = transmissionItems.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final distributionItems =
        items
            .where(
              (item) =>
                  item.description == "DistDemCharge" ||
                  item.description == "DistSysCharge" ||
                  item.description == "SupRetCharge" ||
                  item.description == "SupSysCharge" ||
                  item.description == "MetRetCharge" ||
                  item.description == "MetSysCharge" ||
                  item.description == "PAR" ||
                  item.description == "RFSC" ||
                  item.description == "VATDist",
            )
            .toList();
    final distributionSubtotal = distributionItems.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final total = items.fold(0.0, (sum, item) => sum + item.amount);

    return BillSummary(
      reading: reading,
      presentReading: presentReading,
      usedKwh: usedKwh,
      items: items,
      generationItems: generationItems,
      generationSubtotal: generationSubtotal,
      transmissionItems: transmissionItems,
      transmissionSubtotal: transmissionSubtotal,
      distributionItems: distributionItems,
      distributionSubtotal: distributionSubtotal,
      totalAmount: total,
    );
  }
}
