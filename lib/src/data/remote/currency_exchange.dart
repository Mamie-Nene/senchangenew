import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '/src/methods/response_messages.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/domain/CurrencyExchange.dart';
import '/src/utils/api/api_url.dart';
import 'package:http/http.dart' as http;

class CurrencyExchangeApi {

  Future<List<CurrencyExchange>> getListCurrency(BuildContext context) async {

    final url = Uri.parse(ApiUrl().getCurrencyExchangeList);

    final headers = {
      'Content-Type': 'application/json',
      "apikey": ApiUrl.apiKey,
      // '"x-api-key": dotenv.env['API_KEY']!,

    };

    List<CurrencyExchange> currency = [];

    try {
      final response = await http.get(url, headers: headers);

      debugPrint("response.statusCode for get list currency ${response.statusCode}");
      debugPrint("response.body for get list currency ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {

          List responseData = jsonDecode(response.body);

          if( responseData.isEmpty) return currency;

          currency = responseData.map((e) => CurrencyExchange.fromJson(e)).toList();

          return currency;
      }
    }
    catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted)   return [] ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
    return [];
  }

}