import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:readnbill/models/bill_summary.dart';

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

  Future<void> printBill(BillSummary summary) async {
    String formatChargeLine(String description, double rate, double amount) {
      final desc = description.padRight(15).substring(0, 15);
      final rateText = rate.toStringAsFixed(4).padLeft(8);
      final amountText = amount.toStringAsFixed(2).padLeft(9);

      return "$desc$rateText$amountText";
    }

    await printer.printCustom("BOHECO II", 3, 1);
    await printer.printCustom("READ & BILL", 2, 1);
    await printer.printNewLine();

    await printer.printLeftRight(
      "Date",
      DateTime.now().toString().substring(0, 19),
      0,
    );

    await printer.printNewLine();

    await printer.printCustom("CONSUMER", 2, 1);

    await printer.printLeftRight("Name", summary.reading.consumerName, 0);

    await printer.printLeftRight("Account", summary.reading.accountNumber, 0);

    await printer.printLeftRight(
      "Previous",
      summary.reading.previousReading.toStringAsFixed(0),
      0,
    );

    await printer.printLeftRight(
      "Used kWh",
      summary.usedKwh.toStringAsFixed(0),
      0,
    );

    await printer.printNewLine();
    await printer.printCustom("CHARGES", 2, 1);

    await printer.printCustom("---------------------------------------", 0, 0);

    for (final item in summary.items) {
      await printer.printCustom(
        formatChargeLine(item.description, item.rate, item.amount),
        1,
        0,
      );
    }

    await printer.printNewLine();

    await printer.printLeftRight(
      "TOTAL",
      summary.totalAmount.toStringAsFixed(2),
      1,
    );

    await printer.printNewLine();
    await printer.printCustom("Thank you for using Read & Bill!", 1, 1);

    await printer.paperCut();
  }

  BlueThermalPrinter get printer => _printer;
}
