class BillItem {
  final String description;
  final double rate;
  final double amount;
  final bool isFixedCharge;

  const BillItem({
    required this.description,
    required this.rate,
    required this.amount,
    this.isFixedCharge = false,
  });
}
