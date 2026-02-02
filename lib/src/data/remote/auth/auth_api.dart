import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:senchange/src/utils/variable/http_headers_global_variable.dart';

import '/src/domain/UserEntity.dart';

import '/src/services/secure_storage_service.dart';
import '/src/services/utils.service.dart';
import '/src/services/token_interceptor.dart';

import '/src/methods/storage_management.dart';
import '/src/methods/response_messages.dart';
import '/src/methods/logout_methods.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/api/api_url.dart';



class AuthApi{


  Future<void> loginRequest(BuildContext context,String emailOrUsername, String password) async {

    final url = Uri.parse(ApiUrl().loginUrl);

    // get device info
    final info = await UtilsService.getDeviceInfo();

    final headers = {
      'Content-Type': 'application/json',
      "deviceInfos": "${info['nom']},${info['version']}",
    };


    final body = jsonEncode({
      'usernameOrEmail': emailOrUsername,
      'password': password,
    });

    try {

      final response = await http.post(url, headers: headers, body: body);

      debugPrint(response.body.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {

        var responseData = json.decode(response.body);

        debugPrint(responseData.toString());

        final dynamic isActive = responseData["activate"]; // get active variable
        final dynamic isMfa = responseData["mfa"]; // get mfa variable

        // mfa
        await StorageManagement.setStringStorage("mfa", responseData["mfa"].toString(),);
        // rotation mot de passe
        await StorageManagement.setStringStorage("rotation", responseData["rotation"].toString(),);

        // verifier si le compte est actif --> si oui => page d'accueil si non => page de verification otp

        if (isActive == true) {
          // redirection vers verification otp
          // si le two-factor authentification st actif : rdirection vers la verification
          if (!context.mounted) return ;
          functionWhereUserAccountIsActive(isMfa,context,response.body,responseData,emailOrUsername);
        }
        else {
          if (!context.mounted) return ;
          // Vérifier si le widget est toujours actif avant de naviguer
          Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPage,
              arguments: {
                "action": "signup",
                "email": emailOrUsername,
              }
          );
        }
      }
      else {

        debugPrint(response.statusCode.toString());
        if (!context.mounted) return ;
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(utf8.decode(response.bodyBytes));
          ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
        }
      }
    } catch (e) {
      debugPrint('Error : $e');
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }

  }

  functionWhereUserAccountIsActive(bool isMfa,BuildContext context, bodyResponse,dataResponse,String email){
    // redirection vers verification otp
    // si le two-factor authentification st actif : rdirection vers la verification
    if (isMfa) {
      if (!context.mounted) return ;
      Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPage,
        arguments: {
          "action": "mfa",
          "email": email
        },
      );
    }
    else {
      functionIfMfaIsNotHere(context,bodyResponse,dataResponse);
    }
  }

  functionForDeviceTrusting(BuildContext context, bodyResponse,dataResponse,) async{
    // lui envoyer le code otp
    const trustHeader = {'Content-Type': 'application/json'};
    final trustBody = jsonEncode({"email": dataResponse["userInfo"]["email"],});
    final trustUrl = Uri.parse(ApiUrl().sendOtpForDevice);

    final trustResponse = await http.post(
      trustUrl,
      headers: trustHeader,
      body: trustBody,
    );

    if (trustResponse.statusCode == 200 || trustResponse.statusCode == 201) {
      // rediriger la page de renseignement de son code otp
      if (!context.mounted) return ;
      Navigator.of(context).pushNamed(AppRoutesName.verificationCodeOtpPage ,
        arguments: {
          "action": "trust",
          "email": dataResponse["userInfo"]["email"],
        },
      );

    }
    else {
      final Map<String, dynamic> trustResponseData = jsonDecode(bodyResponse,);
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, trustResponseData["errorDTOS"][0]["errorMessage"],);

    }
  }

  functionIfMfaIsNotHere(BuildContext context,bodyResponse,dataResponse)async{

    // enregistrer le token dans le local storage
  /* await SecureStorageService.saveToken("access_token", dataResponse["accessToken"],);

    ResponseMessageService.showSuccessToast(context, "storing token login ");

    print(await SecureStorageService.getToken("access_token"));*/

    await StorageManagement.setStringStorage("access_token", dataResponse["accessToken"],);

    // enregistrer le numero de telephone dans le storage
    await StorageManagement.setStringStorage("telephone", dataResponse["userInfo"]["phoneNumber"],);

    // enregistrer l'email dans le local storage
    await StorageManagement.setStringStorage("email", dataResponse["userInfo"]["email"],);

    // enregistrer le nom dans le local storage
    await StorageManagement.setStringStorage("nom", dataResponse["userInfo"]["lastName"],);

    // prenom
    await StorageManagement.setStringStorage("prenom", dataResponse["userInfo"]["firstName"],);
    /*  recuperer les infos du device
     final deviceInfo = await StorageManagement.getDeviceInfo();
     verification du trust device*/
    if (dataResponse["trustDevice"] == false) {
      if (!context.mounted) return ;

      functionForDeviceTrusting(context,bodyResponse,dataResponse);
    }
    else {
      if (!context.mounted) return ;
      // Vérifier si le widget est toujours actif avant de naviguer
      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutesName.accueilPage, (Route<dynamic> route) => false,);

    }

  }

  Future<void> register(BuildContext context, UserEntity userRegistered) async {

    // Formulaire valide, traitement des données
    final url = Uri.parse(ApiUrl().signUpUrl);
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      ...userRegistered.toJson(),
      'consent': true,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);

      final responseData = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Vérifier si le widget est toujours actif avant de naviguer
        if (!context.mounted) return ;
        // redirection vers verification otp
        Navigator.of(context).pushNamed(
            AppRoutesName.verificationCodeOtpPage,
            arguments: {
              "action": "signup",
              "email": userRegistered.email
            }
        );

      } else {
        if (!context.mounted) return ;
        ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);

      }
    }
    catch (e) {
      debugPrint("-----------error------------ $e");
      if (!context.mounted) return ;
      ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }

  }

  // fonction pour mettre à jour un utilisateur
  updateUser(BuildContext context, String prenomController, String nomController, String phoneController) async {
    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
    final url = Uri.parse(ApiUrl().updateUserUrl);

    //final token = await SecureStorageService.getToken("access_token");
   /* final token = await StorageManagement.getStorage('access_token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };*/

    final Map<String, dynamic> bodyMap = {
      "firstName": prenomController,
      "lastName": nomController,
      "phoneNumber": phoneController,
    };

    final response = await http.put(
      url,
      headers:HttpHeadersGlobalVariable().getHeaders(),// headers,
      body: jsonEncode(bodyMap),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // mise à jour des valeur dans le shared pref
      StorageManagement.setStringStorage("prenom", prenomController);
      StorageManagement.setStringStorage("nom", nomController);
      StorageManagement.setStringStorage("telephone", phoneController);
     // if (mounted) {
      if (!context.mounted) return null;
        ResponseMessageService.showSuccessToast(context, "Votre profil a été modifié");
      return Navigator.of(context).pushNamed(AppRoutesName.parametrePage);
    //  }
    } else {
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        //if (mounted) {
        if (!context.mounted) return null;
          ResponseMessageService.showErrorToast(
            context,
            responseData["errorDTOS"][0]["errorMessage"],
          );
       // }
      } else {
       // if (mounted) {
        if (!context.mounted) return null;
          ResponseMessageService.showErrorToast(
            context,
            "Une erreur est survenue. Veuillez réessayer plus tard.",
          );
      //  }
      }
    }
  }

  resetPasswordUser(String newPassword,String email, BuildContext context) async {
    final url = Uri.parse(ApiUrl().changePasswordUrl);
    final headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> bodyMap = {
      "email": email,
      "newPassword": newPassword,
    };

    final String body = jsonEncode(bodyMap);
    debugPrint(body);

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) return null;
          ResponseMessageService.showSuccessToast(context, "Mot de passe modifié avec succès",);

          // redirection vers la page de connexion
          Navigator.of(context).pushNamed(AppRoutesName.loginPage);
       // }
      } else {
        if (response.body.isNotEmpty) {
          final responseData = jsonDecode(utf8.decode(response.bodyBytes));
         // if (mounted) {
          if (!context.mounted) return null;
            ResponseMessageService.showErrorToast(
              context,
              responseData["errorDTOS"][0]["errorMessage"],
            );
         // }
        }
      }
    } catch (e) {
      debugPrint("exception");
      // debugPrint(e);
      // if (mounted) {
      //   ResponseMessageService.showErrorToast(
      //     context,
      //     "Une erreur est survenue. Veuillez réessayer plus tard.",
      //   );
      // }
    }
  }


  // fonction pour modifier son mot de passe
  confirmResetPassword(String oldPassword, String newPassword, String confirmPassword,BuildContext context) async {
    final url = Uri.parse(ApiUrl().resetPasswordUrl);

    // final token = await SecureStorageService.getToken('access_token');
    final email = await StorageManagement.getStorage('email');

    /*final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };*/
    final Map<String, dynamic> bodyMap = {
      "usernameOrEmail": email,
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };

    final String body = jsonEncode(bodyMap);

    try {
      final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
      final response = await http.post(url, headers: HttpHeadersGlobalVariable().getHeaders(), body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!context.mounted) return ;
          // deconnecter l'utiliser
          LogoutMethods.logout(context);

          ResponseMessageService.showSuccessToast(context, "Mot de passe modifié avec succès",);
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
    catch (e) {debugPrint("-----------error------------ $e");

    if (!context.mounted) return ;
    ResponseMessageService.showErrorToast(context, AppText.CATCH_ERROR_TEXT,);
    }
  }

  static Future<Response> desactivateAccount(String email) async {

    final url = Uri.parse("${ApiUrl().desactiverCompte}?email=$email",
    );

    final headers = {'Content-Type': 'application/json'};

    final response = await http.patch(url, headers: headers);

    return response;
  }
}