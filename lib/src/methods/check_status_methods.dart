
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Src/presentation/pages/home_pages/accueil.dart';
import '../../main.dart';
import '../presentation/pages/auth/login.dart';
import '../utils/consts/routes/app_routes_name.dart';

class CheckStatusMethods{
  static Future<void> checkAccessToken(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    if (accessToken == null || accessToken.isEmpty) {
      // Rediriger vers la page de connexion
      print("noo acess");
      Navigator.of(context).pushReplacementNamed(AppRoutesName.loginPage);
    }
  }

  // fonction pour la redirection selon si l'acces token est trouvé ou non
  static Future<void> checkLoginStatus(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');

    // Attendre un court instant pour éviter un flash rapide
    await Future.delayed(Duration(seconds: 2));

    // Rediriger l'utilisateur en fonction de la présence du token
    if (accessToken != null) {
      Navigator.of(context).pushReplacementNamed(AppRoutesName.accueilPage);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutesName.loginPage);
    }
  }

  // fonction applé lors que l'utilisateur consulte les pages d'introduction pour ne pas les lui montrer la prochaine fois
  static Future<void> completeIntro(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false,); // Marquer l'introduction comme vue

    // Aller à la page d'accueil et supprimer l'historique de navigation
    Navigator.of(context).pushReplacementNamed(AppRoutesName.loginPage);
  }

}