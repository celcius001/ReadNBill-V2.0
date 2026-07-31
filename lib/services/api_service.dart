import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readnbill/models/route_model.dart';

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
}
