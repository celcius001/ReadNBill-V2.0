import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:readnbill/models/bill_model.dart';
import 'package:readnbill/models/rate_model.dart';
import 'package:readnbill/models/route_model.dart';
import 'package:readnbill/models/tempreading_model.dart';

class ApiService {
  final baseUrl = dotenv.env["API_BASE_URL"]!;

  Future<RouteModel> downloadRoute({required String routeCode}) async {
    final uri = Uri.parse("$baseUrl/route?RouteCode=$routeCode");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      return RouteModel.fromJson(json);
    }

    throw Exception("Failed to download route.");
  }

  Future<List<TempReadingModel>> downloadTemp({
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
      return jsonList.map((json) => TempReadingModel.fromJson(json)).toList();
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

  Future<void> uploadBills(List<BillModel> bills) async {
    final uri = Uri.parse("$baseUrl/bill/upload");

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'bills': bills.map((bill) => bill.toJson()).toList()}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to upload bills: ${response.statusCode}");
    }
  }

  Future<void> uploadTempReadings(List<TempReadingModel> tempReadings) async {
    final uri = Uri.parse("$baseUrl/temp/upload");

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'tempReadings':
            tempReadings.map((tempReading) => tempReading.toJson()).toList(),
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to upload bills: ${response.statusCode}");
    }
  }
}
