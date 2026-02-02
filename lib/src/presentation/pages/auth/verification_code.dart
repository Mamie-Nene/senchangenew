
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:senchange/src/presentation/widgets/app_auth_header.dart';
import 'package:senchange/src/presentation/widgets/auth_page_shell.dart';
import '/src/data/remote/auth/otp_api.dart';

import '/src/utils/api/api_url.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class VerificationCode extends StatefulWidget {
  final String action;
  final String email;
  // montant dans le cas de l'achat
  final String? montant;
  // methode de paiement dans le cas de l'achat
  final String? paymentMethod;

  const VerificationCode({super.key, required this.action, required this.email, this.montant, this.paymentMethod,});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  Uri? url ;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  bool isEnabled = false;

  final _verificationCodeOtpKey = GlobalKey<FormState>();



  chooseUrl(String action){
    switch (action) {
      case "mfa" :
        return Uri.parse(ApiUrl().loginByOtpUrl);

      case "signup":
        return Uri.parse(ApiUrl().activeCompteByOtpURL);

      case "reset":
        return Uri.parse(ApiUrl().forgotPwdWithOtpUrl);

      case "trust":
        return Uri.parse(ApiUrl().activateDevice);

      default :
        return Uri.parse(ApiUrl().submitTransactionWithOtpURL);
    }
  }
  @override
  void initState() {
    url = chooseUrl(widget.action);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final focusedBorderColor = AppColors.mainVioletColor;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    final borderColor = AppColors.orangeFonce;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle:  TextStyle(fontSize: AppDimensions().responsiveFont(context,22), color: AppColors.mainVioletColor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.grisClair),
      ),
    );

    return AuthPageShell(
        isAppBarNeeded:true,
        padding:20,
        isForSignUpPage:false,
        appBar: AppBar(backgroundColor: AppColors.bgColor),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: AppDimensions.h20(context)),
                Text(
                  "Entrez votre code de vérification",
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.h30(context)),

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color:AppColors.textLightGris,
                      fontSize: AppDimensions().responsiveFont(context,16),
                    ),
                    children: [
                      TextSpan(
                        text: "Vous avez reçu un code de verification à l’adresse ",
                      ),
                      TextSpan(
                        text: widget.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppDimensions.h30(context)),

                Center(
                  child: Form(
                    key: _verificationCodeOtpKey,
                    child: Pinput(
                      // You can pass your own SmsRetriever implementation based on any package
                      // in this example we are using the SmartAuth
                      // smsRetriever: smsRetriever,
                      controller: pinController,
                      length: 6,
                      focusNode: focusNode,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      validator: (value) {
                        if (value != null && value.length == 6) {
                          // Le code PIN est valide (6 caractères)
                          setState(() {
                            isEnabled = true; // Met à jour la variable isEnabled
                          });
                          return null; // Aucun message d'erreur
                        } else {
                          // Le code PIN est invalide
                          setState(() {
                            isEnabled = false; // Désactive la variable isEnabled
                          });
                          return "Le PIN doit être composé de 6 chiffres"; // Message d'erreur
                        }
                        },
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                        setState(() {
                          isEnabled = pin.length == 6; // Assure-toi que isEnabled est mis à jour après la saisie complète
                        });
                        },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                        // Mets à jour l'état de isEnabled à chaque modification du PIN
                        setState(() {
                          isEnabled = value.length == 6; // Si le PIN est complet (6 caractères), active le bouton
                        });
                        },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      // onCompleted: (pin) {
                      //   debugPrint('onCompleted: $pin');
                      // },
                      // onChanged: (value) {
                      //   debugPrint('onChanged: $value');
                      // },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9,),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!
                            .copyWith(
                          borderRadius: BorderRadius.circular(8,),
                          border: Border.all(color: focusedBorderColor,),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(
                            color: focusedBorderColor,
                          ),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.h20(context)),
            CustomElevatedButton(
              label: "Valider",
              color: AppColors.orangeColor,
              action: () async {
                if (_verificationCodeOtpKey.currentState != null && _verificationCodeOtpKey.currentState!.validate()) {
                  if(isEnabled){
                    await OtpApi().validateCode( context, pinController.text,widget.action,url!,widget.email,widget.montant,widget.paymentMethod);}
                }
                },
              isEnabled: isEnabled,
              textColor: AppColors.textGrisColor,
            ),
            SizedBox(height: AppDimensions.h20(context)),
            // texte pour le renvoie du code otp
            /* Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous n'avez pas reçu de code ? ",
                              style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                            ),
                            GestureDetector(
                              onTap: () {
                                 /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Signup(),
                                    ),
                                  );*/
                               },
                               child: Text(
                                 "Renvoyer",
                                 style: TextStyle(
                                   fontSize: AppDimensions().responsiveFont(context,16),
                                   color: AppColors.orangeFonce,
                                 ),
                               ),
                             ),
                           ],
                         ),

                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                            children: [
                              TextSpan(
                                text: "Pas encore membre ? ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: "Créer un compte",
                                style: TextStyle(color: AppColors.orangeFonce),
                              ),
                            ],
                          ),
                        ),*/
          ],
      ),
    );
  }
}