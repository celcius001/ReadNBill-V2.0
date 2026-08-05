class TempModel {
  final String servicePeriodEnd;
  final String accountNumber;
  final String route;
  final int sequenceNumber;
  final String consumerName;
  final String consumerAddress;
  final String meterNumber;
  final double previousReading;
  final double powerReading;
  final DateTime? readingDate;
  final String? readBy;
  final String consumerType;
  final String accountStatus;
  final String shortAccountNumber;
  final int multiplier;
  final double coreloss;
  final double corelossKWHLimit;
  final double additionalKWH;
  final double tsfRental;
  final String? schoolTag;
  final String? sdiscountStatus;
  final double kwhConsumption;
  final double qcAmount;
  final double pcamount;
  final double epAmount;
  final double bcAmount;
  final double arrAmount;

  TempModel({
    required this.servicePeriodEnd,
    required this.accountNumber,
    required this.route,
    required this.sequenceNumber,
    required this.consumerName,
    required this.consumerAddress,
    required this.meterNumber,
    required this.previousReading,
    required this.powerReading,
    required this.readingDate,
    required this.readBy,
    required this.consumerType,
    required this.accountStatus,
    required this.shortAccountNumber,
    required this.multiplier,
    required this.coreloss,
    required this.corelossKWHLimit,
    required this.additionalKWH,
    required this.tsfRental,
    required this.schoolTag,
    required this.sdiscountStatus,
    required this.kwhConsumption,
    required this.qcAmount,
    required this.pcamount,
    required this.epAmount,
    required this.bcAmount,
    required this.arrAmount,
  });

  // Used by API
  factory TempModel.fromJson(Map<String, dynamic> json) {
    return TempModel(
      servicePeriodEnd: json['ServicePeriodEnd']?.toString() ?? '',
      accountNumber: json['AccountNumber']?.toString() ?? '',
      route: json['Route']?.toString() ?? '',
      sequenceNumber: (json['SequenceNumber'] as num?)?.toInt() ?? 0,

      consumerName: json['ConsumerName']?.toString() ?? '',
      consumerAddress: json['ConsumerAddress']?.toString() ?? '',
      meterNumber: json['MeterNumber']?.toString() ?? '',

      previousReading: (json['PreviousReading'] as num?)?.toDouble() ?? 0.0,
      powerReading: (json['PowerReadings'] as num?)?.toDouble() ?? 0.0,

      readingDate:
          json['ReadingDate'] != null
              ? DateTime.tryParse(json['ReadingDate'].toString())
              : null,

      readBy: json['ReadBy']?.toString(),

      consumerType: json['ConsumerType']?.toString() ?? '',
      accountStatus: json['AccountStatus']?.toString() ?? '',
      shortAccountNumber: json['ShortAccountNumber']?.toString() ?? '',

      multiplier: (json['Multiplier'] as num?)?.toInt() ?? 0,

      coreloss: (json['Coreloss'] as num?)?.toDouble() ?? 0.0,
      corelossKWHLimit: (json['CorelossKWHLimit'] as num?)?.toDouble() ?? 0.0,
      additionalKWH: (json['AdditionalKWH'] as num?)?.toDouble() ?? 0.0,
      tsfRental: (json['TSFRental'] as num?)?.toDouble() ?? 0.0,

      schoolTag: json['SchoolTag']?.toString(),
      sdiscountStatus: json['SDiscountStatus']?.toString(),

      kwhConsumption: (json['KWHConsumption'] as num?)?.toDouble() ?? 0.0,
      qcAmount: (json['QCAmount'] as num?)?.toDouble() ?? 0.0,
      pcamount: (json['PCAmount'] as num?)?.toDouble() ?? 0.0,
      epAmount: (json['EPAmount'] as num?)?.toDouble() ?? 0.0,
      bcAmount: (json['BCAmount'] as num?)?.toDouble() ?? 0.0,
      arrAmount: (json['ArrAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Used by SQLite
  factory TempModel.fromMap(Map<String, dynamic> map) {
    return TempModel(
      servicePeriodEnd: map['ServicePeriodEnd']?.toString() ?? '',
      accountNumber: map['AccountNumber']?.toString() ?? '',
      route: map['Route']?.toString() ?? '',
      sequenceNumber: (map['SequenceNumber'] as num?)?.toInt() ?? 0,

      consumerName: map['ConsumerName']?.toString() ?? '',
      consumerAddress: map['ConsumerAddress']?.toString() ?? '',
      meterNumber: map['MeterNumber']?.toString() ?? '',

      previousReading: (map['PreviousReading'] as num?)?.toDouble() ?? 0.0,
      powerReading: (map['PowerReadings'] as num?)?.toDouble() ?? 0.0,

      readingDate:
          map['ReadingDate'] != null
              ? DateTime.tryParse(map['ReadingDate'].toString())
              : null,

      readBy: map['ReadBy']?.toString(),

      consumerType: map['ConsumerType']?.toString() ?? '',
      accountStatus: map['AccountStatus']?.toString() ?? '',
      shortAccountNumber: map['ShortAccountNumber']?.toString() ?? '',

      multiplier: (map['Multiplier'] as num?)?.toInt() ?? 0,

      coreloss: (map['Coreloss'] as num?)?.toDouble() ?? 0.0,
      corelossKWHLimit: (map['CorelossKWHLimit'] as num?)?.toDouble() ?? 0.0,
      additionalKWH: (map['AdditionalKWH'] as num?)?.toDouble() ?? 0.0,
      tsfRental: (map['TSFRental'] as num?)?.toDouble() ?? 0.0,

      schoolTag: map['SchoolTag']?.toString(),
      sdiscountStatus: map['SDiscountStatus']?.toString(),

      kwhConsumption: (map['KWHConsumption'] as num?)?.toDouble() ?? 0.0,
      qcAmount: (map['QCAmount'] as num?)?.toDouble() ?? 0.0,
      pcamount: (map['PCAmount'] as num?)?.toDouble() ?? 0.0,
      epAmount: (map['EPAmount'] as num?)?.toDouble() ?? 0.0,
      bcAmount: (map['BCAmount'] as num?)?.toDouble() ?? 0.0,
      arrAmount: (map['ArrAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ServicePeriodEnd': servicePeriodEnd,
      'AccountNumber': accountNumber,
      'Route': route,
      'SequenceNumber': sequenceNumber,
      'ConsumerName': consumerName,
      'ConsumerAddress': consumerAddress,
      'MeterNumber': meterNumber,
      'PreviousReading': previousReading,
      'PowerReadings': powerReading,
      'ReadingDate': readingDate?.toIso8601String(),
      'ReadBy': readBy,
      'ConsumerType': consumerType,
      'AccountStatus': accountStatus,
      'ShortAccountNumber': shortAccountNumber,
      'Multiplier': multiplier,
      'Coreloss': coreloss,
      'CorelossKWHLimit': corelossKWHLimit,
      'AdditionalKWH': additionalKWH,
      'TSFRental': tsfRental,
      'SchoolTag': schoolTag,
      'SDiscountStatus': sdiscountStatus,
      'KWHConsumption': kwhConsumption,
      'QCAmount': qcAmount,
      'PCAmount': pcamount,
      'EPAmount': epAmount,
      'BCAmount': bcAmount,
      'ArrAmount': arrAmount,
    };
  }
}
