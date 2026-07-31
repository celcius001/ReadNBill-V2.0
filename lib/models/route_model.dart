class RouteModel {
  final String routeCode;
  final String townCode;
  final String description;
  final int serviceDayFrom;
  final int serviceDayTo;
  final int dueDay;

  RouteModel({
    required this.routeCode,
    required this.townCode,
    required this.description,
    required this.serviceDayFrom,
    required this.serviceDayTo,
    required this.dueDay,
  });

  // Used by API
  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routeCode: json['RouteCode'],
      townCode: json['TownCode'],
      description: json['Description'],
      serviceDayFrom: int.parse(json['ServiceDayFrom'].toString()),
      serviceDayTo: int.parse(json['ServiceDayTo'].toString()),
      dueDay: int.parse(json['DueDay'].toString()),
    );
  }

  // Used by SQLite
  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      routeCode: map['RouteCode'],
      townCode: map['TownCode'],
      description: map['Description'],
      serviceDayFrom: map['ServiceDayFrom'],
      serviceDayTo: map['ServiceDayTo'],
      dueDay: map['DueDay'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'RouteCode': routeCode,
      'TownCode': townCode,
      'Description': description,
      'ServiceDayFrom': serviceDayFrom,
      'ServiceDayTo': serviceDayTo,
      'DueDay': dueDay,
    };
  }
}
