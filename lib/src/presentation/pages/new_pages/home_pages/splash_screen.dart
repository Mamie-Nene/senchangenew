import 'package:flutter/material.dart';

import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

import '/src/methods/check_status_methods.dart';

class Splashscreen extends StatefulWidget {
  final bool isFirstTime;
  const Splashscreen({super.key, required this.isFirstTime});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {

    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
     /* if (widget.isFirstTime) {
        Navigator.pushReplacementNamed(context, AppRoutesName.introductionPage);
      } else {*/
        CheckStatusMethods.checkLoginStatus(context);
     // }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondVioletColor,
      body: SafeArea(
        top: false,
        child: Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.APP_ICON),
              const CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
