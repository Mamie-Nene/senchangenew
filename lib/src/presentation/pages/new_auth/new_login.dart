import 'package:flutter/material.dart';
import 'package:senchange/src/data/remote/auth/auth_api.dart';
import 'package:senchange/src/presentation/widgets/app_auth_header.dart';
import 'package:senchange/src/presentation/widgets/app_utils.dart';
import 'package:senchange/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/methods/storage_management.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();}

class _LoginScreenState extends State<LoginScreen> {
  final _loginKey = GlobalKey<FormState>();

  bool _isRunning = false;
  bool _isPwdVisible = false;
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
    return Scaffold(
      backgroundColor: AppColors.mainAppColor, // purple background
      body:  Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -40,
              left: -40,
              child: AppUtilsWidget.circleUI(120, Colors.orange.withOpacity(0.25)),
            ),
            Positioned(
              bottom: -20,
              right: -30,
              child: AppUtilsWidget.circleUI(140, Colors.orange.withOpacity(0.20)),
            ),
            // Main Card
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppAuthHeader(title: AppText.AUTH_SUBTITLE_TEXT,subtitle: "Connexion",),

                      Form(
                        key: _loginKey,
                        child:  Column(
                          spacing: 8,
                          children: [
                            AppUtilsWidget().inputLabel("Email"),
                            AppUtilsWidget().inputField(
                               controller:  emailController,
                                hint: "vous@exemple.com",
                              /*fieldLogic: (value) {
                                if (value == null || value.isEmpty) {
                                  return "L'email ou le nom d'utilisateur est requis";
                                }
                                return null;
                              },*/
                              iconData:  Icon(Icons.email_outlined),
                            ),
                            const SizedBox(height: 10),
                            AppUtilsWidget().inputLabel("Mot de passe"),
                            AppUtilsWidget().inputField(
                              controller:  passwordController ,
                                hint: "..........",
                                isPassword: true,
                                isPasswordVisible: _isPwdVisible,
                                suffixIcon:  IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _isPwdVisible = !_isPwdVisible;
                                    });
                                  }, icon: _isPwdVisible? Icon(Icons.visibility):Icon(Icons.visibility_off)
                              ),

                              iconData:Icon(Icons.lock_outline_rounded),
                            ),
                          ],
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutesName.forgotPwdPage);
                          },
                          child:  Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: AppColors.secondAppColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

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
                          onPressed:_isRunning? null : () async {
                            setState(() {
                              _isRunning=true;
                            });
                            if (_loginKey.currentState != null && _loginKey.currentState!.validate()) {
                              await AuthApi().loginRequest(context,emailController.text, passwordController.text,);
                            }
                            setState(() {
                              _isRunning=false;
                            });
                          },
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Pas encore de compte ? "),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutesName.signUpPage);
                            },
                            child: Text(
                              "Inscrivez-vous",
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
            ),
          ],
        ),

    );
  }

}
