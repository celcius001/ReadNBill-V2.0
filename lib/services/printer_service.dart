import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:readnbill/models/bill_summary.dart';
import 'package:readnbill/models/rate_model.dart';

class PrinterService {
  PrinterService._();

  static final PrinterService instance = PrinterService._();

  final BlueThermalPrinter _printer = BlueThermalPrinter.instance;

  BluetoothDevice? connectedDevice;

  Future<List<BluetoothDevice>> getBondedDevices() async {
    return await _printer.getBondedDevices();
  }

  Future<bool> connect(BluetoothDevice device) async {
    try {
      if (await _printer.isConnected ?? false) {
        return true;
      }

      await _printer.connect(device);
      connectedDevice = device;

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> disconnect() async {
    if (await _printer.isConnected ?? false) {
      await _printer.disconnect();
    }
    connectedDevice = null;
  }

  Future<bool> isConnected() async {
    return await _printer.isConnected ?? false;
  }

  Future<void> printBill(BillSummary summary, RateModel rate) async {
    // ==========================================
    // 58mm Printer Formatting
    // ==========================================
    const int lineWidth = 32;
    String alignLeftRight(String left, String right, {int width = lineWidth}) {
      final spaces = width - left.length - right.length;

      if (spaces <= 0) {
        return "$left $right";
      }
      return left + (" " * spaces) + right;
    }

    String alignCharge(String description, double rate, double amount) {
      const int descriptionWidth = 14;
      const int rateWidth = 8;
      const int amountWidth = 10;

      final desc =
          description.length > descriptionWidth
              ? description.substring(0, descriptionWidth)
              : description.padRight(descriptionWidth);

      final rateText = rate.toStringAsFixed(4).padLeft(rateWidth);
      final amountText = amount.toStringAsFixed(2).padLeft(amountWidth);

      return "$desc$rateText$amountText";
    }

    String getCurrentDate() {
      final now = DateTime.now();
      return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    }

    DateTime parseServicePeriod(String date) {
      final parts = date.split("/");

      return DateTime(
        int.parse(parts[2]), // year
        int.parse(parts[0]), // month
        int.parse(parts[1]), // day
      );
    }

    final servicePeriod = parseServicePeriod(summary.reading.servicePeriodEnd);
    final dueDate = DateTime(
      servicePeriod.year,
      servicePeriod.month + 1,
      summary.route.dueDay,
    );

    String formatDate(DateTime date) {
      return "${date.month.toString().padLeft(2, '0')}/"
          "${date.day.toString().padLeft(2, '0')}/"
          "${date.year}";
    }

    await printer.printCustom("BOHOL II ELECTRIC", 3, 1);
    await printer.printCustom("COOPERATIVE, INC.", 3, 1);
    await printer.printCustom("(BOHECO II)", 2, 1);
    await printer.printCustom("Cantagay, Jagna, Bohol", 1, 1);
    await printer.printCustom("VAT Reg. TIN 002-030-585-00000", 1, 1);
    await printer.printNewLine();

    await printer.printCustom("BILLING INVOICE", 2, 1);
    await printer.printNewLine();

    await printer.printCustom(getCurrentDate(), 1, 1);

    await printer.printNewLine();
    await printer.printCustom(summary.reading.accountNumber, 2, 1);
    await printer.printCustom(summary.reading.consumerName, 1, 1);
    await printer.printCustom(summary.reading.consumerAddress, 1, 1);

    await printer.printCustom("TIN: ", 1, 0);
    await printer.printCustom("BStyle: ", 1, 0);
    await printer.printCustom(
      alignLeftRight("Meter No.", summary.reading.meterNumber),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight("Consumer Type", summary.reading.consumerType),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight("Billing Month", summary.reading.servicePeriodEnd),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight(
        "Present Reading",
        summary.presentReading.toStringAsFixed(0),
      ),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight(
        "Previous Reading",
        summary.reading.previousReading.toStringAsFixed(0),
      ),
      1,
      0,
    );

    if (summary.reading.coreloss > 0) {
      await printer.printCustom(
        alignLeftRight("Coreloss", summary.reading.coreloss.toStringAsFixed(0)),
        1,
        0,
      );
    }

    if (summary.reading.additionalKWH > 0) {
      await printer.printCustom(
        alignLeftRight(
          "Additional kWh",
          summary.reading.additionalKWH.toStringAsFixed(0),
        ),
        1,
        0,
      );
    }

    await printer.printCustom(
      alignLeftRight("kWh Used", summary.usedKwh.toStringAsFixed(0)),
      1,
      0,
    );

    await printer.printCustom("--------------------------------", 1, 0);

    // GENERATION CHARGES
    for (final item in summary.generationItems) {
      await printer.printCustom(
        alignCharge(item.description, item.rate, item.amount),
        1,
        0,
      );
    }
    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight(
        "Sub-Total Gen",
        summary.generationSubtotal.toStringAsFixed(2),
      ),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);

    // TRANSMISSION CHARGES
    for (final item in summary.transmissionItems) {
      await printer.printCustom(
        alignCharge(item.description, item.rate, item.amount),
        1,
        0,
      );
    }

    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight(
        "Sub-Total Trans",
        summary.transmissionSubtotal.toStringAsFixed(2),
      ),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);

    // DISTRIBUTION CHARGES
    for (final item in summary.distributionItems) {
      await printer.printCustom(
        alignCharge(item.description, item.rate, item.amount),
        1,
        0,
      );
    }

    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight(
        "Sub-Total DSM",
        summary.distributionSubtotal.toStringAsFixed(2),
      ),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);

    // OTHER CHARGES
    for (final item in summary.otherItems) {
      await printer.printCustom(
        alignCharge(item.description, item.rate, item.amount),
        1,
        0,
      );
    }

    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight(
        "Sub-Total Other",
        summary.otherSubtotal.toStringAsFixed(2),
      ),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);

    // VAT CHARGES
    for (final item in summary.vatItems) {
      await printer.printCustom(
        alignCharge(item.description, item.rate, item.amount),
        1,
        0,
      );
    }

    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight("Sub-Total VAT", summary.vatSubtotal.toStringAsFixed(2)),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);

    // GOVT CHARGES
    for (final item in summary.govtItems) {
      await printer.printCustom(
        alignCharge(item.description, item.rate, item.amount),
        1,
        0,
      );
    }

    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight("Sub-Total GOVT", summary.govtSubtotal.toStringAsFixed(2)),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom("Total Billing (VAT Inclusive)", 1, 0);
    await printer.printCustom(
      "PHP ${summary.totalAmount.toStringAsFixed(2)}",
      2,
      2,
    );
    await printer.printCustom(
      alignLeftRight(
        "VATableSales",
        summary.vatSaleSubtotal.toStringAsFixed(2),
      ),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight("VATAmount", summary.vatSubtotal.toStringAsFixed(2)),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight(
        "VATZeroRatedSales",
        summary.vatZeroSubtotal.toStringAsFixed(2),
      ),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight("VATExemptSales", summary.govtSubtotal.toStringAsFixed(2)),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom("Total Amount Due", 1, 0);
    await printer.printCustom(
      "PHP ${summary.totalAmount.toStringAsFixed(2)}",
      2,
      2,
    );
    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight("Due Date", formatDate(dueDate)),
      1,
      0,
    );
    await printer.printCustom(
      alignLeftRight("Power Rate", "${rate.generationRate.toStringAsFixed(4)}"),
      1,
      0,
    );
    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom(
      alignLeftRight("Generated By", "Read&Bill System"),
      1,
      0,
    );
    await printer.printCustom(alignLeftRight("Version", "2.0.0"), 1, 0);
    await printer.printCustom(alignLeftRight("User", ""), 1, 0);
    await printer.printCustom(alignLeftRight("AC No.", ""), 1, 0);
    await printer.printCustom(alignLeftRight("Date Issued", ""), 1, 0);
    await printer.printCustom(
      alignLeftRight("Series Range", "BI1000000000000000"),
      1,
      0,
    );
    await printer.printCustom(alignLeftRight("To", "BI1999999999999999"), 1, 0);
    await printer.printCustom("--------------------------------", 1, 0);
    await printer.printCustom("This is NOT an official receipt.", 1, 1);
    await printer.printCustom("Please pay at any BOHECO II", 1, 1);
    await printer.printCustom("Business Center.", 1, 1);
    await printer.printNewLine();
    await printer.printNewLine();
    await printer.printNewLine();

    // await printer.printNewLine();

    // await printer.printLeftRight(
    //   "TOTAL",
    //   summary.totalAmount.toStringAsFixed(2),
    //   1,
    // );

    // await printer.printNewLine();
    // await printer.printCustom("Thank you for using Read & Bill!", 1, 1);

    await printer.paperCut();
  }

  BlueThermalPrinter get printer => _printer;
}
