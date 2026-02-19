import 'package:flutter/material.dart';

import '/src/presentation/widgets/app_utils.dart';
import '/src/presentation/widgets/app_auth_header.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _forgotPwdKey = GlobalKey<FormState>(); // Définition de la clé
  bool _isRunning = false;
  TextEditingController emailOrPhoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainAppColor,
      body:  Stack(
          children: [

            Positioned(
              top: -40,
              left: -40,
              child: AppUtilsWidget.circleUI(
                  120, Colors.orange.withOpacity(0.25)),
            ),
            Positioned(
              bottom: 40,
              right: -30,
              child: AppUtilsWidget.circleUI(
                  140, Colors.orange.withOpacity(0.20)),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: SingleChildScrollView(
                  child: Column(

                    children: [
                      Align(alignment:Alignment.centerLeft,child: BackButton()),

                      AppAuthHeader(title: AppText.AUTH_SUBTITLE_TEXT,subtitle: "Réinitialisation",),

                      Text(AppText.FORGET_PWD_SUBTITLE_TEXT,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 22),

                     // AppUtilsWidget().inputLabel("Email ou Téléphone"), const SizedBox(height: 8),
                    Form(
                      key: _forgotPwdKey,
                      child : AppUtilsWidget().inputField(
                        controller: emailOrPhoneController,
                        hint: '770000000',
                        iconData: Icon(Icons.phone),
                      ),
                    ),

                      const SizedBox(height: 22),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:  AppColors.secondAppColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _isRunning?null: () async {
                            setState(() {
                              _isRunning=true;
                            });
                            if (_forgotPwdKey.currentState != null && _forgotPwdKey.currentState!.validate()) {
                             // await  OtpApi().sendOtpCodeForPasswordForgetten(context, emailController.text,Constants.appNameForHeaders);
                            }
                            setState(() {
                              _isRunning=false;
                            });
                          },
                          child: const Text(
                            "Réinitialiser le mot de passe",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child:  Text(
                          "Retour à la page de connexion",
                          style: TextStyle(
                            color: AppColors.secondAppColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
