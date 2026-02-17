import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/src/methods/response_messages.dart';
import '/src/presentation/widgets/app_auth_header.dart';
import '/src/services/open_link_service.dart';
import '/src/utils/api/api_url.dart';

import '/src/presentation/widgets/app_utils.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signUpKey = GlobalKey<FormState>();
  bool _isPwdVisible = false;
  bool isConditionsAccepted = false;
  bool _isRunning = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nomCompletController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    telephoneController.dispose();
    passwordController.dispose();
    nomCompletController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: AppColors.mainAppColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -40,
              left: -40,
              child:
              AppUtilsWidget.circleUI(120, Colors.orange.withOpacity(0.25)),
            ),
            Positioned(
              bottom: 40,
              right: -30,
              child:
              AppUtilsWidget.circleUI(140, Colors.orange.withOpacity(0.20)),
            ),
            Container(
            //  margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
             /* decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
              ),*/
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(alignment:Alignment.centerLeft,child: BackButton()),

                    AppAuthHeader(title: "Création de compte",subtitle: "Inscription",),
                      Form(
                        key: _signUpKey,
                        child:  Column(
                      spacing: 8,
                      children: [
                      AppUtilsWidget().inputLabel("Nom Complet"),
                      AppUtilsWidget().inputField(
                        controller: nomCompletController,
                        hint:"Votre nom complet",
                        iconData: Icon(Icons.person),
                      ),

                      const SizedBox(height: 8),

                      AppUtilsWidget().inputLabel("Nom d'utilisateur",),
                        AppUtilsWidget().inputField(
                          controller: usernameController,
                          hint:"username",
                          iconData: Icon(Icons.person),
                        ),

                      const SizedBox(height: 8),
                      AppUtilsWidget().inputLabel("Email"),
                      AppUtilsWidget().inputField(
                          controller: emailController,
                          hint:"vous@exemple.com",
                          iconData: Icon(Icons.email_outlined),
                      ),

                      const SizedBox(height: 8),

                      AppUtilsWidget().inputLabel("Téléphone"),

                      AppUtilsWidget().inputField(
                          controller: telephoneController,
                          hint: "770000000",
                          iconData: Icon(Icons.phone),
                       ),

                      const SizedBox(height: 8),

                      AppUtilsWidget().inputLabel("Mot de passe"),
                      AppUtilsWidget().inputField(
                        controller: passwordController,
                        hint:"..........",
                        iconData:Icon(Icons.lock_outline_rounded),
                        isPassword: true,
                        isPasswordVisible: _isPwdVisible,
                        suffixIcon:  IconButton(
                            onPressed: (){
                              setState(() {
                                _isPwdVisible = !_isPwdVisible;
                              });
                            }, icon: _isPwdVisible? Icon(Icons.visibility):Icon(Icons.visibility_off)
                        ),

                      ),

                      const SizedBox(height: 8),

                      AppUtilsWidget().inputLabel("Confirmer mot de passe"),
                      AppUtilsWidget().inputField(
                          controller: confirmPasswordController,
                          hint:"..........",
                          iconData: Icon(Icons.email_outlined),
                          isPassword: true,
                          isPasswordVisible: _isPwdVisible,
                          suffixIcon:  IconButton(
                              onPressed: (){
                                setState(() {
                                  _isPwdVisible = !_isPwdVisible;
                                });
                              }, icon: _isPwdVisible? Icon(Icons.visibility):Icon(Icons.visibility_off)
                          ),

                          fieldLogic:  (value) {
                          if (value == null || value.isEmpty) {
                              return "Veuillez confirmer votre mot de passe";
                            }
                            if (value != passwordController.text) {
                              return "Les mots de passe ne sont pas identiques";
                            }
                            return null;
                          }
                          ),
                        ],
                      ),
                    ),

                      SizedBox(height: AppDimensions.h20(context)),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading, // Place la case à cocher avant le texte
                        title: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: AppDimensions().responsiveFont(context,16),
                            ),
                            children: [
                              TextSpan(text: "J'accepte les "),
                              TextSpan(
                                text: "conditions générales d'utilisation",
                                style: TextStyle(
                                  color: AppColors.mainVioletColor,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () => OpenLinkService.openExternalLink(ApiUrl().senChangeCGULink),
                              ),
                            ],
                          ),
                        ),
                        value: isConditionsAccepted,
                        activeColor: AppColors.orangeColor,
                        contentPadding: EdgeInsets.all(0),
                        onChanged: (bool? value) {
                          setState(() {
                            isConditionsAccepted = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondAppColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          onPressed: _isRunning? null :() async {
                              setState(() {
                                _isRunning=true;
                              });
                              if (_signUpKey.currentState != null &&   _signUpKey.currentState!.validate()) {
                                if (!isConditionsAccepted) {
                                  ResponseMessageService.showErrorToast(context, "Merci d'accepter nos conditions générales d'utilisation pour continuer",);
                                } else {

                                 // UserEntity userRegistered = UserEntity(prenomController.text, nomController.text, telephoneController.text, emailController.text, usernameController.text, passwordController.text);

                                 // await  AuthApi().register(context, userRegistered).onError((error, stackTrace) =>  passwordController.setText(""));
                                }
                              }
                              setState(() {
                                _isRunning=false;
                              });
                            },

                          child: const Text(
                            "Créer un compte",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Déjà un compte ? "),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              "Se connecter",
                              style: TextStyle(
                                color: AppColors.secondAppColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
    );
  }

}
