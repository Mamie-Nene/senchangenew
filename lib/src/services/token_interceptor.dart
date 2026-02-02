import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:senchange/src/services/secure_storage_service.dart';

import '/src/methods/response_messages.dart';
import '/src/services/utils.service.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '../utils/variable/global_variable.dart';

import 'dart:convert';
import '/src/methods/storage_management.dart';


class TokenInterceptor extends InterceptorContract {

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    debugPrint('----- Request Interceptor -----');
    debugPrint(request.toString());
    debugPrint(request.headers.toString());

    // check token avaibility
    final isTokenExpired = await UtilsService.isTokenExpired();

    if (isTokenExpired) {
      // remove token
      //new gestion token
      await SecureStorageService.deleteToken("access_token");
      // Avant --> StorageManagement.removeStorage("access_token");

      // Redirection on loginPage using the globalKey
      navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutesName.loginPage, (route) => false);

      // response message for user
      scaffoldMessengerKey.currentState?.showSnackBar(
          ResponseMessageService().getSnackBarForInformation()
      );
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response,}) async {
    if (response is Response) {
      try {
        if (response.bodyBytes.isNotEmpty) {
          final decodedBody = utf8.decode(response.bodyBytes);

          final newResponse = Response(
            decodedBody,
            response.statusCode,
            headers: response.headers,
            request: response.request,
            isRedirect: response.isRedirect,
            persistentConnection: response.persistentConnection,
            reasonPhrase: response.reasonPhrase,
          );

          return newResponse;
        }
      } catch (e) {
        debugPrint("Erreur de décodage UTF-8: $e");
      }
    }

    return response;
  }
}