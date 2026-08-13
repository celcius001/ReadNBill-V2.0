import 'package:readnbill/models/bill_summary.dart';
import 'package:readnbill/models/rate_model.dart';
import 'package:readnbill/models/route_model.dart';
import 'package:readnbill/models/tempreading_model.dart';
import 'package:readnbill/services/bill_items.dart';

class BillingCalculator {
  static BillSummary generateBill({
    required RateModel rate,
    required RouteModel route,
    required TempModel reading,
    required double previousReading,
    required double presentReading,
  }) {
    final usedKwh =
        (presentReading - previousReading) +
        (reading.additionalKWH + reading.coreloss) * reading.multiplier;

    final items = <BillItem>[];

    // Senior Citizen Discount
    double seniorCitizenDiscount = 0.0;

    void addCharge(String description, double? rateValue, double quantity) {
      if (rateValue == null || rateValue <= 0) return;

      final amount = rateValue * quantity;

      final roundedAmount = double.parse(amount.toStringAsFixed(2));

      items.add(
        BillItem(
          description: description,
          rate: rateValue,
          amount: roundedAmount,
        ),
      );
    }

    if (reading.sdiscountStatus == "YES") {
      final a =
          rate.genSysCharge +
          rate.transSysCharge +
          rate.sysLossCharge +
          (rate.metSysCharge ?? 0.0) +
          rate.distribSysCharge +
          (rate.supplySysCharge ?? 0.0);
      final b = rate.metRetCusCharge + rate.lifeLineRateSubsidy;

      if (usedKwh < 100) {
        seniorCitizenDiscount = -(((a * usedKwh) + b) * 0.05);
      } else {
        seniorCitizenDiscount =
            -(((a * usedKwh) + rate.metRetCusCharge) * 0.05);
      }
    }

    double round2(double value) {
      return double.parse(value.toStringAsFixed(2));
    }

    final dcc = round2(rate.distribDemCharge ?? 0.0);
    final srcc = round2(rate.supplyRetCusCharge);
    final mrcc = round2(rate.metRetCusCharge);

    final vatDistAmount =
        ((usedKwh * rate.vatDist) + (dcc + srcc + mrcc) * 0.12);

    final vatOtherAmount =
        ((usedKwh * rate.vatOthers) + (reading.tsfRental * 0.12));

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
    addCharge("TransDemCharge", rate.transDemCharge, usedKwh);
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

    // OTHERS
    addCharge("Lifeline", rate.lifeLineRateSubsidy, usedKwh);
    addCharge("Olra", rate.olraCharge, usedKwh);
    addCharge("OlraCurr", rate.olraCurrCharge, usedKwh);
    addCharge("Olra3Curr", rate.olra3Charge, usedKwh);
    if (seniorCitizenDiscount < 0) {
      items.add(
        BillItem(
          description: "SrDisc",
          rate: 0.05,
          amount: seniorCitizenDiscount,
        ),
      );
    } else {
      addCharge("SrSub", rate.seniorCitizenSubsidy, usedKwh);
    }
    addCharge("Osra", rate.osrRACharge, usedKwh);

    // VAT
    if (vatDistAmount != 0) {
      items.add(
        BillItem(
          description: "VATDist",
          rate: rate.vatDist,
          amount: round2(vatDistAmount),
        ),
      );
    }
    if (vatOtherAmount != 0) {
      items.add(
        BillItem(
          description: "VATOther",
          rate: rate.vatOthers,
          amount: round2(vatOtherAmount),
        ),
      );
    }

    // GOVT
    addCharge("UC-ME-SPUG", rate.ucMissElecCharge, usedKwh);
    addCharge("UC-REDCI", rate.meredciCharge, usedKwh);
    addCharge("NPC-SD", rate.npcsdCharge, usedKwh);
    addCharge("GEAAllow", rate.strandedCost, usedKwh);
    addCharge("FITAllow", rate.fitAllCharge, usedKwh);
    addCharge("EnvCharge", rate.ucEnvCharge, usedKwh);

    // ADDITIONAL CHARGES
    addCharge("Ftx", rate.franchiseTax, usedKwh);
    addCharge("Rpt", rate.realPropertyTax, usedKwh);
    addCharge("QCAmount", reading.qcAmount, usedKwh);
    addCharge("EPAmount", reading.epAmount, usedKwh);
    addCharge("PCAmount", reading.pcAmount, usedKwh);
    addCharge("BCAmount", reading.bcAmount, usedKwh);
    addCharge("TSFRental", reading.tsfRental, usedKwh);

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
                  item.description == "TransDemCharge" ||
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
                  item.description == "RFSC",
            )
            .toList();
    final distributionSubtotal = distributionItems.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final otherItems =
        items
            .where(
              (item) =>
                  item.description == "Lifeline" ||
                  item.description == "Olra" ||
                  item.description == "OlraCurr" ||
                  item.description == "Olra3Curr" ||
                  item.description == "SrSub" ||
                  item.description == "SrDisc" ||
                  item.description == "QCAmount" ||
                  item.description == "EPAmount" ||
                  item.description == "PCAmount" ||
                  item.description == "BCAmount" ||
                  item.description == "TSFRental",
            )
            .toList();
    final otherSubtotal = otherItems.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final vatItems =
        items
            .where(
              (item) =>
                  item.description == "Rpt" ||
                  item.description == "Ftx" ||
                  item.description == "VATDist" ||
                  item.description == "VATOther",
            )
            .toList();
    final vatSubtotal = vatItems.fold(0.0, (sum, item) => sum + item.amount);

    final govtItems =
        items
            .where(
              (item) =>
                  item.description == "UC-ME-SPUG" ||
                  item.description == "UC-REDCI" ||
                  item.description == "NPC-SD" ||
                  item.description == "GEAAllow" ||
                  item.description == "FITAllow" ||
                  item.description == "EnvCharge",
            )
            .toList();
    final govtSubtotal = govtItems.fold(0.0, (sum, item) => sum + item.amount);

    final vatSaleItems =
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
                  item.description == "Lifeline" ||
                  item.description == "SrSub",
            )
            .toList();
    final vatSaleSubtotal = vatSaleItems.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final vatZeroItems =
        items
            .where(
              (item) =>
                  item.description == "GenSys" ||
                  item.description == "Psalm" ||
                  item.description == "Oga" ||
                  item.description == "OgaCurr" ||
                  item.description == "Oga3Curr" ||
                  item.description == "TransSysCharge" ||
                  item.description == "TransDemCharge" ||
                  item.description == "SysLoss" ||
                  item.description == "OtcaDem" ||
                  item.description == "OtcaDemCurr" ||
                  item.description == "OtcaDem3Curr" ||
                  item.description == "VATGen" ||
                  item.description == "VATTrans" ||
                  item.description == "VATSL" ||
                  item.description == "AncSvcsCharge" ||
                  item.description == "OtcaSysCurr" ||
                  item.description == "Otca3SysCurr" ||
                  item.description == "Osla" ||
                  item.description == "OslaCurr" ||
                  item.description == "Osla3Curr" ||
                  item.description == "Olra" ||
                  item.description == "OlraCurr" ||
                  item.description == "Olra3Curr" ||
                  item.description == "Osra" ||
                  item.description == "Ftx" ||
                  item.description == "Rpt" ||
                  item.description == "QCAmount" ||
                  item.description == "EPAmount" ||
                  item.description == "PCAmount" ||
                  item.description == "BCAmount" ||
                  item.description == "SrDisc",
            )
            .toList();
    final vatZeroSubtotal = vatZeroItems.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );

    final totalAmount =
        generationSubtotal +
        transmissionSubtotal +
        distributionSubtotal +
        otherSubtotal +
        vatSubtotal +
        govtSubtotal;

    return BillSummary(
      reading: reading,
      route: route,
      presentReading: presentReading,
      usedKwh: usedKwh,
      items: items,
      generationItems: generationItems,
      generationSubtotal: generationSubtotal,
      transmissionItems: transmissionItems,
      transmissionSubtotal: transmissionSubtotal,
      distributionItems: distributionItems,
      distributionSubtotal: distributionSubtotal,
      otherItems: otherItems,
      otherSubtotal: otherSubtotal,
      vatItems: vatItems,
      vatSubtotal: vatSubtotal,
      govtItems: govtItems,
      govtSubtotal: govtSubtotal,
      vatSaleItems: vatSaleItems,
      vatSaleSubtotal: vatSaleSubtotal,
      vatZeroItems: vatZeroItems,
      vatZeroSubtotal: vatZeroSubtotal,
      totalAmount: totalAmount,
    );
  }
}
