import 'dart:convert';
import 'package:http/http.dart' as http;
import '/src/domain/models/TransactionModel.dart';
import '/src/utils/api/api_url.dart';


class TransactionService {
  final String baseUrl = ApiUrl.baseUrl;

  Future<List<TransactionModel>> getTransactions() async {
    final response = await http.get(
      Uri.parse("$baseUrl/transactions"),
      headers: {
        "Authorization": "Bearer YOUR_TOKEN",
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load transactions");
    }
  }
}
