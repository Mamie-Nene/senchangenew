
import 'package:flutter/material.dart';
import '/src/data/remote/auth/auth_api.dart';
import '../../widgets/custom_text_form_field.dart';
import '/src/utils/consts/constants.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';



class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _resetPwdKey = GlobalKey<FormState>(); // Définition de la clé


  resetPwdBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          child: Center(
            child: Padding(
              padding:  EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 40 : 20),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Vous êtes sur le point de modifier votre mot de passe. Voulez-vous continuer ?",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppDimensions().responsiveFont(context,18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: AppDimensions.h20(context)),
                  CustomElevatedButton(
                    label: "Oui",
                    color: AppColors.mainVioletColor,
                    action: () {
                      // modification du mot de passe
                      AuthApi().confirmResetPassword(
                          oldPasswordController.text,
                          newPasswordController.text,
                          confirmPasswordController.text,
                          context
                      );
                    },
                    textColor: Colors.white,
                  ),

                  SizedBox(height: AppDimensions.h15(context)),

                  CustomElevatedButton(
                    label: "Non",
                    color: AppColors.textGrisSecondColor,
                    action: () {
                      Navigator.pop(context);
                    },
                    textColor: AppColors.textGrisColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text("Modifier mon mot de passe"),
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding:  EdgeInsets.all(MediaQuery.of(context).size.width > 600 ? 40 : 20),
        child: Form(
          key: _resetPwdKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    PasswordField(
                      label: "Ancien mot de passe",
                      placeholder: "",
                      controller: oldPasswordController,
                      logic: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ce champs est requis";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.h15(context)),
                    PasswordField(
                      label: "Nouveau mot de passe",
                      placeholder: "",
                      controller: newPasswordController,
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
                        if (!Constants.passwordRegExp.hasMatch(value)) {
                          return "Le mot de passe doit contenir au mois une lettre majuscule, un caractère spécial et un chiffre";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.h15(context)),
                    PasswordField(
                      label: "Confirmer votre mot de passe",
                      placeholder: "",
                      controller: confirmPasswordController,
                      logic: (value) {
                        if (value == null || value.isEmpty) {
                          return "Veuillez confirmer votre mot de passe";
                        }
                        if (value != newPasswordController.text) {
                          return "Les mots de passe ne correspondent pas";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              CustomElevatedButton(
                label: "Modifier",
                color: AppColors.orangeColor,
                textColor: Colors.black,
                action: () {
                  if (_resetPwdKey.currentState != null && _resetPwdKey.currentState!.validate()) {
                    resetPwdBottomSheet(context);
                  }
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
