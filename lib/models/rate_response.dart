import "package:readnbill/models/rate_model.dart";

class RateResponse {
  final int status;
  final bool success;
  final List<RateModel> data;

  RateResponse({
    required this.status,
    required this.success,
    required this.data,
  });

  factory RateResponse.fromJson(Map<String, dynamic> json) {
    return RateResponse(
      status: json["Status"] ?? 0,
      success: json["Success"] ?? false,
      data:
          (json['Data'] as List<dynamic>? ?? [])
              .map((item) => RateModel.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }
}
