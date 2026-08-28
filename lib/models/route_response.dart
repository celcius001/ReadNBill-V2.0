import "route_model.dart";

class RouteResponse {
  final int status;
  final bool success;
  final List<RouteModel> data;

  RouteResponse({
    required this.status,
    required this.success,
    required this.data,
  });

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    return RouteResponse(
      status: json["Status"] ?? 0,
      success: json["Success"] ?? false,
      data:
          (json["Data"] as List<dynamic>? ?? [])
              .map((item) => RouteModel.fromJson(item))
              .toList(),
    );
  }
}
