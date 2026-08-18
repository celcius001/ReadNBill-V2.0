class ReadingModel {
  // ---- SQLite-only fields (not part of the API payload) ----
  final int? id;
  final bool isUploaded;

  final String servicePeriodEnd;
  final String accountNumber;
  final double powerReading;
  final DateTime? readingDate;
  final String? readBy;

  ReadingModel({
    this.id,
    this.isUploaded = false,
    required this.servicePeriodEnd,
    required this.accountNumber,
    required this.powerReading,
    required this.readingDate,
    required this.readBy,
  });

  // Used by API
  factory ReadingModel.fromJson(Map<String, dynamic> json) {
    return ReadingModel(
      servicePeriodEnd: json['ServicePeriodEnd']?.toString() ?? '',
      accountNumber: json['AccountNumber']?.toString() ?? '',
      powerReading: (json['PowerReadings'] as num?)?.toDouble() ?? 0.0,
      readingDate:
          json['ReadingDate'] != null
              ? DateTime.tryParse(json['ReadingDate'].toString())
              : null,

      readBy: json['ReadBy']?.toString(),
    );
  }

  // Used by SQLite
  factory ReadingModel.fromMap(Map<String, dynamic> map) {
    return ReadingModel(
      id: map['id'] as int?,
      isUploaded: (map['is_uploaded'] as int?) == 1,
      servicePeriodEnd: map['ServicePeriodEnd']?.toString() ?? '',
      accountNumber: map['AccountNumber']?.toString() ?? '',
      powerReading: (map['PowerReadings'] as num?)?.toDouble() ?? 0.0,
      readingDate:
          map['ReadingDate'] != null
              ? DateTime.tryParse(map['ReadingDate'].toString())
              : null,
      readBy: map['ReadBy']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // Don't set 'id' when inserting a new row — leave it out so SQLite
      // auto-increments. It's included here so updates/copies can carry it.
      if (id != null) 'id': id,
      'is_uploaded': isUploaded ? 1 : 0,
      'ServicePeriodEnd': servicePeriodEnd,
      'AccountNumber': accountNumber,
      'PowerReadings': powerReading,
      'ReadingDate': readingDate?.toIso8601String(),
      'ReadBy': readBy,
    };
  }

  String? formatSqlDate(DateTime? date) {
    if (date == null) return null;

    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  String? formatSqlDateTime(DateTime? date) {
    if (date == null) return null;

    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}:"
        "${date.second.toString().padLeft(2, '0')}";
  }

  /// Map used specifically for uploading to the API — excludes the
  /// SQLite-only id/is_uploaded fields.
  Map<String, dynamic> toJson() {
    final map = toMap();

    // Don't upload SQLite-only fields
    map.remove('id');
    map.remove('is_uploaded');

    // SQL DATE
    map['ServicePeriodEnd'] = servicePeriodEnd;

    // SQL DATETIME
    map['ReadingDate'] = formatSqlDateTime(readingDate);

    return map;
  }
}
