
import 'package:flutter/material.dart';

import '/src/presentation/widgets/app_auth_header.dart';
import '/src/data/remote/auth/otp_api.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/constants.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();
  final _forgotPwdKey = GlobalKey<FormState>(); // Définition de la clé
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(backgroundColor: AppColors.bgColor),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              const AppAuthHeader(),
               SizedBox(height: AppDimensions.h20(context)),
              // container
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border(
                      top: BorderSide(color: AppColors.orangeColor, width: 1),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _forgotPwdKey,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                               SizedBox(height: AppDimensions.h20(context)),
                              Text(
                                "Entrez votre adresse email",
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
                                  children: const [
                                    TextSpan(
                                      text: "Vous allez recevoir un code OTP à cette adresse",
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: AppDimensions.h30(context)),

                              Center(
                                child: CustomTextFormField(
                                  label: "",
                                  type: TextInputType.emailAddress,
                                  controller: emailController,
                                  logic: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "L'email est requis";
                                    }
                                    if (!Constants.emailRegExp.hasMatch(
                                      value,
                                    )) {
                                      return "L'email est incorrect";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                           SizedBox(height: AppDimensions.h20(context)),

                          CustomElevatedButton(
                            label: "Suivant",
                            color: _isRunning? Colors.grey.shade200:AppColors.orangeColor,
                            textColor: Colors.black,
                            action: _isRunning?null: () async {
                              setState(() {
                                _isRunning=true;
                              });
                              if (_forgotPwdKey.currentState != null && _forgotPwdKey.currentState!.validate()) {
                                await  OtpApi().sendOtpCodeForPasswordForgetten(context, emailController.text,Constants.appNameForHeaders);
                              }
                              setState(() {
                                _isRunning=false;
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
