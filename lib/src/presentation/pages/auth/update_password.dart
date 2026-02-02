
import 'package:flutter/material.dart';
import '/src/presentation/widgets/auth_page_shell.dart';

import '/src/data/remote/auth/auth_api.dart';
import '/src/utils/consts/constants.dart';
import '../../widgets/custom_text_form_field.dart';

import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class UpdatePassword extends StatefulWidget {
  final String email;
  const UpdatePassword({super.key, required this.email});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _updatePwdKey = GlobalKey<FormState>(); // Définition de la clé


  @override
  Widget build(BuildContext context) {
    return AuthPageShell(
        isAppBarNeeded:true,
        padding:20,
        isForSignUpPage:false,
        appBar: AppBar(backgroundColor: AppColors.bgColor),

      child: Form(
        key: _updatePwdKey,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: AppDimensions.h20(context)),
                Text(
                  "Réinitialisez votre mot de passe",
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.h30(context)),
                PasswordField(
                  label: "Entrez votre nouveau mot de passe",
                  placeholder: "",
                  controller: passwordController,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ce champs est requis";
                    }
                    if (value.length < 8) {
                      return "Le mot de passe doit contenir au moins 8 caratères";
                    }
                    if (value.length > 21) {
                      return "Le mot de passe ne doit pas dépasser 21 caratères";
                    }
                    if (!Constants.passwordRegExp.hasMatch(
                      value,
                    )) {
                      return "Le mot de passe doit contenir au mois une lettre majuscule, un caractère spécial et un chiffre";
                    }
                    return null;
                    },
                ),
                SizedBox(height: AppDimensions.h15(context)),
                PasswordField(
                  label: "Confirmez votre mot de passe",
                  placeholder: "",
                  controller: confirmPasswordController,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez confirmer votre mot de passe";
                    }
                    if (value != passwordController.text) {
                      return "Les mots de passe ne correspondent pas";
                    }
                    return null;
                    },
                ),
              ],
            ),
            SizedBox(height: AppDimensions.h20(context)),

            CustomElevatedButton(
              label: "Confirmer",
              color: AppColors.orangeColor,
              textColor: Colors.black,
              action: () {
                if (_updatePwdKey.currentState != null && _updatePwdKey.currentState!.validate()) {
                  // modification du mot de passe
                  AuthApi().resetPasswordUser(passwordController.text,widget.email,context);
                }
                },
            ),
          ],
        ),
      ),
    );
  }
}
