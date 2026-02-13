
import 'package:flutter/material.dart';
import '/src/services/secure_storage_service.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/src/utils/variable/global_variable.dart';

class LogoutMethods{
  // deconnexion
  static Future<void> logout(context) async {
    /*final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');*/
    await SecureStorageService.deleteToken("access_token");
    navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutesName.loginPage,
          (Route<dynamic> route) => false,
    );
  }

}