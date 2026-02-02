import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:senchange/src/data/remote/auth/auth_api.dart';

import '/src/methods/logout_methods.dart';
import '/src/methods/storage_management.dart';
import '/src/methods/response_messages.dart';
import '/src/services/token_interceptor.dart';
import '/src/services/secure_storage_service.dart';

import '/src/utils/api/api_url.dart';

class SecurityApi{
  // fonction pour activer ou desactiver un parametre (TWO FACTOR, Rotation MDP)
  changeParams(String paramName) async {
    final url = Uri.parse("${ApiUrl().changeParametre}?name=$paramName");

    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);

    //final token = await SecureStorageService.getToken('access_token');
    final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    final response = await http.patch(url, headers: headers);

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (paramName == "MFA") {
        // mettre à jour la valeur dans le shared prefrences
        StorageManagement.setStringStorage("mfa", responseData["results"].toString(),);
      }
      if (paramName == "ROTATION_PASSWORD") {
        StorageManagement.setStringStorage("rotation", responseData["results"].toString(),);
      }
    }

  }

  desactivateAccount(BuildContext context) async {
    // recuperer l'email dans le local storage
    var email = await StorageManagement.getStorage("email");
    debugPrint("------------email----------- $email");

    final Response result = await AuthApi.desactivateAccount(email!);

    debugPrint("------------decativate account----------- ${result.body.toString()}");
    // final response = jsonDecode(utf8.decode(result.bodyBytes));

    debugPrint(result.statusCode.toString());

    if (result.statusCode == 200 || result.statusCode == 201) {
      // deconnexion
      if (!context.mounted) return ;
        ResponseMessageService.showSuccessToast(context, "Votre compte a été désactivé");
        LogoutMethods.logout(context);

    } else {
        if (result.body.isNotEmpty) {
          final responseData = jsonDecode(utf8.decode(result.bodyBytes));
          if (!context.mounted) return ;
          ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
        }
    }
  }

}