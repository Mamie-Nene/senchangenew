import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '/src/domain/UserEntity.dart';
import '/src/presentation/widgets/auth_page_shell.dart';

import '/src/data/remote/auth/auth_api.dart';
import '/src/services/open_link_service.dart';

import '/src/methods/response_messages.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';
import '/src/presentation/widgets/phone_field.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/constants.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/api/api_url.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _signUpKey = GlobalKey<FormState>();

  bool isConditionsAccepted = false;
  bool _isRunning = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
     emailController.dispose();
     telephoneController.dispose();
     passwordController.dispose();
     nomController.dispose();
     prenomController.dispose();
     confirmPasswordController.dispose();
     usernameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
        isAppBarNeeded:false,
        padding:40,
        isForSignUpPage:true,
        child: Form(
        key: _signUpKey,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Inscription",
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,25),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.h20(context)),
                CustomTextFormField(
                  label: "Prénom",
                  required: true,
                  controller: prenomController,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le prénom est requis";
                    }
                    return null;
                    },
                ),
                SizedBox(height: AppDimensions.h20(context)),
                CustomTextFormField(
                  label: "Nom",
                  required: true,
                  controller: nomController,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le nom est requis";
                    }
                    return null;
                    },
                ),

                SizedBox(height: AppDimensions.h20(context)),
                PhoneNumberField(
                  label: "Téléphone",
                  placeholder: "",
                  required: true,
                  controller: telephoneController,
                ),
                SizedBox(height: AppDimensions.h20(context)),

                CustomTextFormField(
                  label: "Email",
                  required: true,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "L'email est requis";
                    }
                    if (!Constants.emailRegExp.hasMatch(value)) {
                      return "L'email est incorrect";
                    }
                    return null;
                    },
                ),

                SizedBox(height: AppDimensions.h20(context)),

                CustomTextFormField(
                  label: "Nom d'utilisateur",
                  controller: usernameController,
                  required: true,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le nom d'utilisateur est requis";
                    }
                    return null;
                    },
                ),

                SizedBox(height: AppDimensions.h20(context)),
                PasswordField(
                  label: "Mot de passe",
                  required: true,
                  placeholder: "",
                  controller: passwordController,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le mot de passe est requis";
                    }
                    if (value.length < 8) {
                      return AppText.PWD_LENGHT_INFERIOR_CHECK_TEXT;
                    }
                    if (value.length > 21) {
                      return AppText.PWD_LENGHT_SUPERIOR_CHECK_TEXT;
                    }
                    if (!Constants.passwordRegExp.hasMatch(value)) {
                      return AppText.PWD_CONTROL_CHECK_TEXT;
                    }
                    return null;
                    },
                ),

                SizedBox(height: AppDimensions.h20(context)),

                PasswordField(
                  label: "Confirmez votre mot de passe",
                  placeholder: "",
                  required: true,
                  controller: confirmPasswordController,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez confirmer votre mot de passe";
                    }
                    if (value != passwordController.text) {
                      return "Les mots de passe ne sont pas identiques";
                    }
                    return null;
                    },
                ),
              ],
            ),

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

            SizedBox(height: AppDimensions.h20(context)),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _isRunning?Colors.grey:AppColors.orangeColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: _isRunning? null :() async {
                    setState(() {
                      _isRunning=true;
                    });
                    if (_signUpKey.currentState != null &&   _signUpKey.currentState!.validate()) {
                      if (!isConditionsAccepted) {
                        ResponseMessageService.showErrorToast(context, "Merci d'accepter nos conditions générales d'utilisation pour continuer",);
                      } else {
                        UserEntity userRegistered = UserEntity(prenomController.text, nomController.text, telephoneController.text, emailController.text, usernameController.text, passwordController.text);
                                      // enregistrement des données d'inscription
                        await  AuthApi().register(
                            context,
                            userRegistered
                        ).onError((error, stackTrace) =>  passwordController.setText(""));
                      }
                    }
                    setState(() {
                      _isRunning=false;
                    });
                    },
                  child:  Text("S'inscrire",
                    style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            SizedBox(height: AppDimensions.h20(context)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Déjà membre ? ",
                  style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutesName.loginPage);
                    },
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                      fontSize: AppDimensions().responsiveFont(context,16),
                      color: AppColors.orangeFonce,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}