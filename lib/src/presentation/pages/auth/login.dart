
import 'package:flutter/material.dart';

import '/src/presentation/widgets/auth_page_shell.dart';
import '/src/data/remote/auth/auth_api.dart';

import '/src/methods/storage_management.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';
import '/src/presentation/widgets/main_button.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  bool _isRunning = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  setUserEmailOrUsername() async {
    // check if email/username exist on local storage
    var email = await StorageManagement.getStorage("email");
    if (email != null && email.isNotEmpty) {
      setState(() {
        emailController.text= email;
      });
     // emailController.setText(email);
    }
  }

  @override
  void initState() {
    // update emailController with last email connection data
    setUserEmailOrUsername();

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // resizeToAvoidBottomInset: false, // Désactive le redimensionnement
    return AuthPageShell(
      isAppBarNeeded:false,
      padding:70,
      isForSignUpPage:false,
      child:  Form(
        key: _loginKey,
        child: ListView(
          children: [
            Center(
              child: Text(
                "Connexion",
                style: TextStyle(
                  fontSize:AppDimensions().responsiveFont(context, 25),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height:AppDimensions.h30(context)),

            CustomTextFormField(
                  label: "Email ou nom d'utilisateur",
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "L'email ou le nom d'utilisateur est requis";
                    }
                    return null;
                    },
                ),
            SizedBox(height:AppDimensions.h20(context)),

            PasswordField(
                  label: "Mot de passe",
                  placeholder: "",
                  controller: passwordController,
                  logic: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le mot de passe est requis";
                    }
                    return null;
                    },
                ),

            SizedBox(height:AppDimensions.h10(context)),

            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutesName.forgotPwdPage);
                  },
                child: Text(
                  "Mot de passe oublié",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize:AppDimensions().responsiveFont(context, 16),
                    color: AppColors.textGrisColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height:AppDimensions.h10(context)),
            GestureDetector(
              onTap: _isRunning? null : () async {
                setState(() {
                  _isRunning=true;
                });
                if (_loginKey.currentState!.validate()) {
                  await AuthApi().loginRequest(context,emailController.text, passwordController.text,);
                }
                setState(() {
                  _isRunning=false;
                });
                },
              child: MainButton(
                backgroundColor: _isRunning?Colors.grey:AppColors.orangeColor,
                label: "Se connecter",
              ),
            ),
            SizedBox(height:AppDimensions.h20(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Pas encore membre ? ",
                  style: TextStyle(fontSize:AppDimensions().responsiveFont(context, 16)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutesName.signUpPage);
                    },
                  child: Text(
                    "Créer un compte",
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