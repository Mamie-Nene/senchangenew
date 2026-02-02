import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import '/src/domain/WalletEntity.dart';

import '/src/services/secure_storage_service.dart';
import '/src/methods/response_messages.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/methods/storage_management.dart';
import '/src/services/token_interceptor.dart';
import '/src/utils/api/api_url.dart';


class OperationApi{

  // --------------------------- Function to Get List Wallets (dynamic)  --------------------------------

  Future getWalletsForDropdownList(BuildContext context) async {
    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse(ApiUrl().getListWallet);

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    dynamic wallets;

    try {
      final response = await http.get(url, headers: headers);

      debugPrint("response.statusCode for get list wallets ${response.statusCode}");
      debugPrint("response.body for get list wallets ${response.body}");


      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
            wallets = List<Map<String, String>>.from(
              responseData['results'].where((wallet) => wallet["actif"] == true).map(
                    (wallet) => {
                  "label": wallet["nameWallet"].toString(),
                  "blockChainType": wallet["blockChainType"].toString(),
                  "nameBlockchain": wallet["nameBlockchain"].toString(),
                  "address": wallet["address"].toString(),
                },
              ),
            );
            return wallets;
        }
      } else {
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

  // --------------------------- Function to Get and Show Montant à Payer -------------------------------

  Future getAmountToPayForOperation(BuildContext context,int amount,String typeTransaction) async {
    final url = Uri.parse(ApiUrl().calculAmount);

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    final Map<String, dynamic> bodyMap = {"amount": amount, "type":typeTransaction};

    final body = jsonEncode(bodyMap);

    try {
      final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
      final response = await http.post(url, headers: headers, body: body);
      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return responseData['results'];
       }
    } catch (e) {
      debugPrint("-----------error------------ $e");

      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);

    }
  }

  // -------------------------- Function to Get SenChange Wallet Number By selected blockchainType -------------------------------
   Future getSenchangeWallet(String typeBlockchain,BuildContext context) async {
    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse("${ApiUrl().getSenChangeWallet}?blockChainType=$typeBlockchain",
    );

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);

          if (responseData["results"] != null && responseData["results"][0]["address"] != null) {
            return responseData["results"][0]["address"];
          }

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
    } catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }

  // ----------------------- Function To Buy Crypto  -------------------------------

  //1er redirection sboul be replaced or he must return on the accueil?
  buyCrypto(BuildContext context,String montantUsdtController, String montantToPayController,String addressWallet,String selectedMethod ) async {
    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse(ApiUrl().saveTransaction); // Remplace par ton URL

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    final mont = montantUsdtController.replaceAll(RegExp(r'\s+'), '');
    final montanFcfa = montantToPayController.replaceAll(RegExp(r'\s+'), '',);

    final Map<String, dynamic> bodyMap = {
      "addressWallet": addressWallet,
      "amount": int.parse(montanFcfa),
      "amountInit": int.parse(mont),
      "type": "ACHAT",
      // "operator": selectedMobileMoney['operator'],
    };

    final String body = jsonEncode(bodyMap);

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final email = await StorageManagement.getStorage("email");
        if (!context.mounted) return ;
       // Navigator.pop(context);
        Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPageWithAllArgs,
          arguments: {
            "action": "achat",
            "email": email!,
            "montant": montanFcfa,
            "paymentMethod": selectedMethod,
          },
        );
      }
      else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          if (!context.mounted) return ;
          Navigator.pop(context);
          ResponseMessageService.showErrorToast(context,
            responseData["errorDTOS"][0]["errorMessage"],
          );

        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");

      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);

    }
  }

  // ----------------------- Function To Sell Crypto -------------------------------

  sellCrypto(BuildContext context,String montantUsdtController,String montantToPayController,selectedWallet,String walletCrediteController, String phoneUsed, selectedMobileMoney) async {
    final url = Uri.parse(ApiUrl().saveTransaction);

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    final mont = montantUsdtController.replaceAll(RegExp(r'\s+'), '');
    final montanFcfa = montantToPayController.replaceAll(RegExp(r'\s+'), '',);

    final Map<String, dynamic> bodyMap = {
      "addressWallet": selectedWallet["address"],
      "addressOwner": walletCrediteController,
      "amountInit": int.parse(mont),
      "amount": int.parse(montanFcfa),
      "type": "VENTE",
      "phoneNumber": phoneUsed,
      "operator": selectedMobileMoney['operator'],
    };

    final body = jsonEncode(bodyMap);
    print(body.toString());

    try {
      final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
      final response = await http.post(url, headers: headers, body: body);

      final responseData = jsonDecode(response.body);
      print("responseData $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final email = await StorageManagement.getStorage("email");

        if (!context.mounted) return ;
       // Navigator.pop(context);
        // redirection vers la page d'otp
        // recuperer l'email de l'utilisateur connecté
        Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPage,
            arguments: {
              "action": "vente",
              "email": email!
            }
        );

      } else {
        if (response.statusCode == 403) {
          if (!context.mounted) return ;
          Navigator.pop(context);
          ResponseMessageService.showErrorToast(
            context,
            "Une erreur s'est produite su l'initialisation de la transaction",
          );

        } else {
          if (response.body.isNotEmpty && response.body.isNotEmpty) {
            final responseData = jsonDecode(response.body);
            if (!context.mounted) return ;
            Navigator.pop(context);
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

  // ----------------------- Function to Save Exchange -------------------------------

  Future saveExchangeCrypto(BuildContext context,String fromCurrency, String toCurrency, String toDeviseController,String userDeviseController,String phoneController) async {
    final url = Uri.parse(ApiUrl().saveTransaction);

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    final montant = toDeviseController.replaceAll(RegExp(r'\s+'), '');

    String type = getType(fromCurrency, toCurrency);

    var body = jsonEncode({
      "amount": double.parse(montant),
      "amountInit": double.parse(userDeviseController),
      "type": type,
      "phoneNumber": phoneController,
    });


    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final email = await StorageManagement.getStorage("email");
      if (!context.mounted) return ;
    //  Navigator.pop(context);
      Navigator.of(context).pushNamed(
          AppRoutesName.verificationCodeOtpPage,
          arguments: {
            "action": "echange", "email": email!
          }
      );
    } else {
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        if (!context.mounted) return ;
        Navigator.pop(context);
        ResponseMessageService.showErrorToast(
          context,
          responseData["errorDTOS"][0]["errorMessage"],
        );

      }
    }
  }

  // ----------------------- Function to Get Exchange Type -------------------------------

  String getType(String fromCurrency, String toCurrency) {
    if (fromCurrency == "FCFA") {
      if (toCurrency == "Dollar") {
        return "ACHAT_DOLLAR";
      }
      if (toCurrency == "Euro") {
        return "ACHAT_EURO";
      }
    } else if (fromCurrency == "Dollar") {
      return "VENTE_DOLLAR";
    } else if (fromCurrency == "Euro") {
      return "VENTE_EURO";
    }

    return "";
  }

  // ----------------------- Get Montant à Recevoir -------------------------------

  Future getAmountForExchange(double amount, String fromCurrency, String toCurrency) async {
    final url = Uri.parse(ApiUrl().calculAmount);

    //final token = await SecureStorageService.getToken('access_token');
 final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    String type = getType(fromCurrency, toCurrency);

    final Map<String, dynamic> bodyMap = {"amount": amount, "type": type};

    final String body = jsonEncode(bodyMap);

    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);

        return responseData['results']['totalAmount'].toString();

      }
    }
  }

}