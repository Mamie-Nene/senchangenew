import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http/intercepted_http.dart';

import '/src/domain/WalletEntity.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/api/api_url.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/services/secure_storage_service.dart';
import '/src/methods/storage_management.dart';
import '/src/methods/response_messages.dart';
import '/src/services/token_interceptor.dart';

class WalletApi{

  Future saveWallet(BuildContext context, String name, String address, String blockChainType,) async {
    final url = Uri.parse(ApiUrl().createWallet);

    //final token = await SecureStorageService.getToken('access_token');

     final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };
    final Map<String, dynamic> bodyMap = {
      "name": name,
      "address": address,
      "blockChainType": blockChainType,
    };

    final body = jsonEncode(bodyMap);

    try {
      final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) return ;
          ResponseMessageService.showSuccessToast(context, "Portefeuille ajouté avec succès",);
         return Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesName.walletsPage, (Route<dynamic> route) => false,);

      } else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          if (!context.mounted) return ;
            ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
          //}
        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");
        
        if (!context.mounted) return ;
           ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);

    }
  }

  Future updateWallet(String name, String address, String blockChainType, String walletId, BuildContext context) async {

    final url = Uri.parse("${ApiUrl().updateWallet}/$walletId");

    //final token = await SecureStorageService.getToken('access_token');

     final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };
    final Map<String, dynamic> bodyMap = {
      "name": name,
      "address": address,
      "blockChainType": blockChainType,
    };

    final body = jsonEncode(bodyMap);

    try {
      final http = InterceptedHttp.build(interceptors: [ TokenInterceptor()]);
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) return ;
          ResponseMessageService.showSuccessToast(context, "Wallet modifié avec succès");
          return Navigator.of(context).pushNamed(AppRoutesName.walletsPage);

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

  Future archiveWallet(BuildContext context, int walletId, action, index) async {
    try {
      bool isActive;

      final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

      final url = Uri.parse("${ApiUrl().archiveWallet}/$walletId");

      //final token = await SecureStorageService.getToken('access_token');

       final token = await StorageManagement.getStorage('access_token');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Ajout du token ici
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isNotEmpty) {

          if (!context.mounted) return ;
          Navigator.pop(context);
          ResponseMessageService.showSuccessToast(context,
            action == "activer" ? "Le portefeuille a été activé" : "Le portefeuille a été désactivé",
          );

          if (action == 'activer') {isActive = true;}
          else {isActive = false;}

          return isActive;
        }
      } else {
        if (response.body.isNotEmpty) {
          if (!context.mounted) return ;
          final responseData = jsonDecode(response.body);
          ResponseMessageService.showErrorToast(
            context,
            responseData["errorDTOS"][0]["errorMessage"],
          );
        }
      }
    } catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);}
  }

  Future getWallets(BuildContext context) async {

    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse(ApiUrl().getListWallet,);

    //final token = await SecureStorageService.getToken('access_token');

     final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };
    List<WalletEntity> wallets = [];

    try {
      final response = await http.get(url, headers: headers);

      debugPrint("response.statusCode for get list wallets ${response.statusCode}");
      debugPrint("response.body for get list wallets ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {

        if (response.body.isNotEmpty) {

          final responseData = jsonDecode(response.body);

          List data  = responseData['results'];

          if( data.isEmpty) return wallets;

          wallets = data.map((e) => WalletEntity.fromJson(e)).toList();

          return wallets;
        }
      }
      else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(response.body);
          if (!context.mounted) return ;
          ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
        }
      }
    }
    catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }

  Future getWalletsWithData(BuildContext context) async {
    dynamic wallets;
    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    final url = Uri.parse(ApiUrl().getListWallet);

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
          // if (wallets != null && responseData['results'] != null) {

            wallets = List<Map<String, String>>.from(
              responseData['results']
                  .where((wallet) => wallet["actif"] == true)
                  .map(
                    (wallet) => {
                  "label": wallet["nameWallet"].toString(),
                  "blockChainType": wallet["blockChainType"].toString(),
                  "nameBlockchain": wallet["nameBlockchain"].toString(),
                  "address": wallet["address"].toString(),
                },
              ),
            );


          print("liste des wallets récupérés");
          print(wallets);
          return wallets;
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
    } catch (e) {debugPrint("-----------error------------ $e");
        
        if (!context.mounted) return ;
           ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }



}