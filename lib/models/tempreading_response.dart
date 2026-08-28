import "package:readnbill/models/tempreading_model.dart";

class TempReadingResponse {
  final int status;
  final bool success;
  final List<TempReadingModel> data;

  TempReadingResponse({
    required this.status,
    required this.success,
    required this.data,
  });

  factory TempReadingResponse.fromJson(Map<String, dynamic> json) {
    return TempReadingResponse(
      status: json["Status"] ?? 0,
      success: json["Success"] ?? false,
      data:
          (json['Data'] as List<dynamic>? ?? [])
              .map(
                (item) =>
                    TempReadingModel.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
