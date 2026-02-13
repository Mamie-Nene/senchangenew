import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:senchange/src/domain/NewTransactionEntity.dart';
import '/src/utils/variable/http_headers_global_variable.dart';
import '/src/domain/TransactionEntity.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/methods/storage_management.dart';
import '/src/methods/response_messages.dart';
import '/src/services/secure_storage_service.dart';
import '/src/utils/api/api_url.dart';
import '/src/services/token_interceptor.dart';

class TransactionApi{

  //  ------------------------------- Get Transactions History -------------------------------

  Future getHistoriqueTransactions(BuildContext context) async {

    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse(ApiUrl().getHistoriqueTransaction);
    // final url = Uri.parse(ApiUrl().getAllHistoriqueTransaction);

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');


    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    List<TransactionEntity> historique = [];

    try {
      final response = await http.get(url, headers: HttpHeadersGlobalVariable().getHeaders());

      debugPrint("response.statusCode for get list transactions ${response.statusCode}");
      debugPrint("response.body for get list transactions ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {

        final responseData = jsonDecode(response.body);
       // final content = responseData['results']; // for test

        List data  = responseData['results'];
       // List data  = content['content']; // for test

        if( data.isEmpty) return historique;

        historique = data.map((e) =>TransactionEntity.fromJson(e)).toList();

        return historique;
      }
      else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          if (!context.mounted) return ;
            ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }
  Future getHistoriqueTransactionsNew(BuildContext context,) async {

    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse(ApiUrl().getHistoriqueTransaction);

    List<NewTransactionEntity> historique = [];

    try {
    //  final response = await http.get(url, headers: HttpHeadersGlobalVariable().getHeaders());
      final response = await http.get(url, headers: HttpHeadersGlobalVariable().getHeaders());

      debugPrint("response.statusCode for get list transactions ${response.statusCode}");
      debugPrint("response.body for get list transactions ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {

        final responseData = jsonDecode(response.body);
       // final content = responseData['results']; // for test List data  = responseData['results']; // List data  = content['content']; // for test

        print(responseData);
        if( responseData.isEmpty) return historique;

        historique = responseData.map((e) =>NewTransactionEntity.fromJson(e)).toList();

        return historique;
      }
      else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          if (!context.mounted) return ;
            ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }

  //  ------------------------------- Load Again Waiting Transaction -------------------------------

  loadAgainWaitingTransaction(BuildContext context, TransactionEntity transaction) async {

    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse("${ApiUrl().relancerTransaction}/${transaction.transactionId}",);

    //final token = await SecureStorageService.getToken('access_token');
 /*final token = await StorageManagement.getStorage('access_token');


    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };*/

    try {
      final response = await http.get(url, headers: HttpHeadersGlobalVariable().getHeaders());//headers

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) return ;
          Navigator.pop(context);

          // redirection vers la page de validation du code otp
        final email = await StorageManagement.getStorage("email");
        if (!context.mounted) return ;
        if(transaction.typeTransaction=="ACHAT"){
          Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPageWith3Args,
              arguments: {
                "action": "achat",
                "email": email!,
                "montant":transaction.amountChange.toString(),
              }
          );
        }
        else {
          Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPage,
              arguments: {
                  "action": transaction.typeTransaction.toLowerCase(),//action
                  "email": email!,
                }
            );
        }

      } else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);

          if (!context.mounted) return ;
            Navigator.pop(context);
            ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],
            );
        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }

  //  ------------------------------- Cancel Waiting Transaction -------------------------------

  cancelWaitingTransaction(BuildContext context, TransactionEntity transaction) async {
    try {

      final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

      final url = Uri.parse("${ApiUrl().annulerTransaction}/${transaction.transactionId}");

      //final token = await SecureStorageService.getToken('access_token');
/* final token = await StorageManagement.getStorage('access_token');


      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Ajout du token ici
      };
*/
      final response = await http.delete(url, headers: HttpHeadersGlobalVariable().getHeaders());

      if (response.statusCode == 200 || response.statusCode == 201) {

        if (!context.mounted) return ;
          Navigator.pop(context);
          ResponseMessageService.showSuccessToast(context, "Votre transaction a été annulée",);
         return Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesName.accueilPage, (Route<dynamic> route) => false,);

      } else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);

          if (!context.mounted) return ;
            Navigator.pop(context);
          return  ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
        } else {
          if (!context.mounted) return ;
            Navigator.pop(context);
            ResponseMessageService.showErrorToast(
              context,
              "Une erreur est survenue. Veuillez réessayer plus tard.",
            );
        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }

  //  ------------------------------- Get Transaction Status -------------------------------

  getTransactionStatus(BuildContext context,TransactionEntity transaction) async {
    int currentStep;

    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse("${ApiUrl().getTransactionStatus}/${transaction.transactionId}",);

    //final token = await SecureStorageService.getToken('access_token');

    try {
      final response = await http.get(url, headers: HttpHeadersGlobalVariable().getHeaders());
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          print(responseData);
          if (responseData['results']['statusTransaction'] == "WAITING_OTP") {
            return currentStep = -1;

          }
          if (responseData['results']['statusTransaction'] == "INIT") {
            return currentStep = 1;

          }
          if (responseData['results']['statusTransaction'] == "PENDING") {
            return currentStep = 2;

          }
          if (responseData['results']['statusTransaction'] == "ACCEPTED") {
            return currentStep = 3;

          }

          if (responseData['results']['statusTransaction'] == "REJECTED") {
              currentStep = 3;
        }
      } else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          if (!context.mounted) return ;
            ResponseMessageService.showErrorToast(
              context,
              responseData["errorDTOS"][0]["errorMessage"],
            );
          }
        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }
}