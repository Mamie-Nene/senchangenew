
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:senchange/src/services/secure_storage_service.dart';

import '../../../../Src/utils/consts/constants.dart';
import '../../../utils/consts/app_specifications/allDirectories.dart';
import '/src/methods/storage_management.dart';
import '/src/services/token_interceptor.dart';
import '../../../services/open_link_service.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/api/api_url.dart';
import '/src/methods/response_messages.dart';

import 'package:http/http.dart' as http;

class OtpApi{

  chooseRedirectionForNoOperation(String action, BuildContext context, String email ){
    switch (action) {
      case "signup":
        return  Navigator.of(context).pushNamed(AppRoutesName.loginPage);

      case "reset":
        return Navigator.of(context).pushNamed(AppRoutesName.updatePwdPage,
            arguments: {"email": email}
        );

      case "trust":
        return Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesName.accueilPage,
              (Route<dynamic> route) => false,);


    }
  }
  chooseRedirectionForOperation(String action, BuildContext context){
    switch (action) {
      case "vente":
        ResponseMessageService.showSuccessToast(
          context,
          "Votre vente a été initialisée",
        );
        // redirection vers la page d'accueil
        return Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutesName.accueilPage,
              (route) => false,
        );
        //return Navigator.of(context).pushNamed(AppRoutesName.accueilPage);

      case "echange":
        ResponseMessageService.showSuccessToast(
          context,
          "Votre échange a été initialisé",
        );
        // redirection vers la page d'accueil
        return  Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutesName.accueilPage,
              (route) => false,
        );
      //  return  Navigator.of(context).pushNamed(AppRoutesName.accueilPage);

    }
  }

  functionForNoOperation(String action,Map<String, String> headers,final body, final url , BuildContext context, String email) async{

    final response = await http.post(url, headers: headers, body: body);

    debugPrint('Url: ${url.toString()}');
    debugPrint("headers $headers");
    debugPrint("body $body");

    debugPrint("---------------fin requete ----------------");
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    debugPrint(" réponse and status code ${responseData.toString()} , ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {

        if (action == "mfa") {
          if (response.body.isNotEmpty) {

            final responseData = jsonDecode(utf8.decode(response.bodyBytes),);
            // enregistrer le token dans le local storage
            // await SecureStorageService.saveToken("access_token", responseData["accessToken"],);
            await StorageManagement.setStringStorage("access_token", responseData["accessToken"],);

            // enregistrer le numero de telephone dans le storage
            await StorageManagement.setStringStorage("telephone", responseData["userInfo"]["phoneNumber"],);

            // enregistrer l'email dans le local storage
            if (responseData["userInfo"]["email"] != null) {
              await StorageManagement.setStringStorage("email", responseData["userInfo"]["email"],);
            }

            // enregistrer le nom dans le local storage
            await StorageManagement.setStringStorage("nom", responseData["userInfo"]["lastName"],
            );

            // prenom
            await StorageManagement.setStringStorage("prenom", responseData["userInfo"]["firstName"],
            );
          }
          if (!context.mounted) return null;
          return  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesName.accueilPage, (Route<dynamic> route) => false,);
        }
        else {
          if (!context.mounted) return null;
          chooseRedirectionForNoOperation(action,context, email);
        }
    }
    else {
        if (response.body.isNotEmpty) {
          if (!context.mounted) return null;
          ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
      }
    }
  }

  functionForOperation(String action,Map<String, String> headers,final body, final url, BuildContext context, String? montant, String? paymentMethod)async{

    final httpCallback = InterceptedHttp.build(interceptors: [TokenInterceptor()],);

    final response = await httpCallback.post(
      url,
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {

        if (action == "achat") {
          if (!context.mounted) return null;
          // redirection vers la page d'accueil
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutesName.accueilPage,
                (route) => false,
          );
       //   Navigator.of(context).pushNamed(AppRoutesName.accueilPage);

          if (paymentMethod == "wave") {
            //  redirection vers le lien de paiement de wave
            final waveLink = "${ApiUrl().waveLink}?amount=$montant";
            //final waveLink = OpenLinkService.getWaveLink(montant);

            OpenLinkService.openExternalLink(waveLink);
          } else {
            // if (mounted) {
            //   ResponseMessageService.showSuccessToast(context, "OM bientot");
            // }
          }
        }
        else {
          if (!context.mounted) return null;
          chooseRedirectionForOperation(action,context);
        }
    }
    else {

        if (!context.mounted) return null;
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseData = jsonDecode(response.body,); // Décodage JSON
          ResponseMessageService.showErrorToast(
            context,
            responseData["errorDTOS"][0]["errorMessage"],
          );
        } else {
          ResponseMessageService.showErrorToast(
            context,
            "Une erreur est survenue. Veuillez réessayer plus tard.",
          );
        }
      //}
    }
  }

  validateCode(BuildContext context, String code, String action, Uri url, String email,String? montant, String? paymentMethod) async {
    // signup : user/activate-by-otp
    // Remplace par ton URL
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({"code": code});

    try {
      if (action == "mfa" || action == "signup" || action == "reset" || action == "trust") {
        functionForNoOperation(action,headers,body,url,context, email);
      }
      else {
        // transaction : vente, achat, achat
        // recuperer et mettre le token dans le header

        //final token = await SecureStorageService.getToken('access_token');
        final token = await StorageManagement.getStorage('access_token');
        headers['Authorization'] = 'Bearer $token';

        functionForOperation(action,headers,body,url,context,montant,paymentMethod);

      }
    } catch (e) {
      debugPrint('Exception: $e');
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);

      // if (mounted) {
      //   ResponseMessageService.showErrorToast(
      //     context,
      //     "Une erreur est survenue. Veuillez réessayer plus tard.",
      //   );
      // }
    }
  }

  // fontion de validation du code otp
  sendOtpCodeForPasswordForgetten(BuildContext context, String email, String appName) async {
    final url = Uri.parse(ApiUrl().sendOtpForPasswordForgotten);

    final headers = {
      'Content-Type': 'application/json',
      'appName':appName,
    };

    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);

      debugPrint(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        // redirection vers la page verification otp
        if (!context.mounted) return null;
          Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPage,
              arguments: {"action": "reset", "email": email}
          );

      } else {
      //  if (mounted) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          // ResponseMessageService.showErrorToast(context, "Identifiants incorrects");
          if (!context.mounted) return null;
            ResponseMessageService.showErrorToast(
              context,
              responseData["errorDTOS"][0]["errorMessage"],
            );
         // }
       // }
      }
    } catch (e) {
     debugPrint('Exception: $e');
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);

      //if (mounted) {
        // normal
        // ResponseMessageService.showErrorToast(
        //   context,
        //   // "erreur : $e",
        //   "Une erreur est survenue. Veuillez réessayer plus tard.",
        // );
     // }
    }
  }
}