import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readnbill/models/rate_model.dart';
import 'package:readnbill/models/route_model.dart';
import 'package:readnbill/models/tempreading_model.dart';

class ApiService {
  static const String baseUrl = "http://192.168.0.142:8000/api/v1";

  Future<RouteModel> downloadRoute({required String routeCode}) async {
    final uri = Uri.parse("$baseUrl/route?RouteCode=$routeCode");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      return RouteModel.fromJson(json);
    }

    throw Exception("Failed to download route.");
  }

  Future<List<TempModel>> downloadTemp({
    required String routeCode,
    required int seqFrom,
    required int seqTo,
  }) async {
    final uri = Uri.parse(
      "$baseUrl/temp?RouteCode=$routeCode&SeqFrom=$seqFrom&SeqTo=$seqTo",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => TempModel.fromJson(json)).toList();
    }

    throw Exception("Failed to download route.");
  }

  Future<List<RateModel>> downloadRates() async {
    final uri = Uri.parse("$baseUrl/rate");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => RateModel.fromJson(json)).toList();
    }

    throw Exception("Failed to download route.");
  }
}
