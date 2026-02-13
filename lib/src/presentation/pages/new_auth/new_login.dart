import 'package:flutter/material.dart';
import 'package:senchange/src/data/remote/auth/auth_api.dart';
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

  /*setUserEmailOrUsername() async {
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
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B3B5B), // purple background
      body: SafeArea(
        child: Stack(
          children: [
            // Decorative circles
            Positioned(
              top: -40,
              left: -40,
              child: _circle(120, Colors.orange.withOpacity(0.25)),
            ),
            Positioned(
              bottom: 40,
              right: -30,
              child: _circle(140, Colors.orange.withOpacity(0.20)),
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
                      // Header inside card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B3B5B),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              "»» SENCHANGE",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Acheter et vendre de la cryptomonnaie en\n toute simplicité",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Connexion",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3D2A3A),
                        ),
                      ),

                      const SizedBox(height: 22),

                  Form(
                    key: _loginKey,
                      child:  Column(
                        children: [
                      _inputLabel("Email"),
                      const SizedBox(height: 8),
                      _inputField(emailController,hint: "vous@exemple.com"),

                      const SizedBox(height: 18),

                      _inputLabel("Mot de passe"),
                      const SizedBox(height: 8),
                      _inputField(passwordController ,hint: "..........", isPassword: true,isPwdVisible: _isPwdVisible),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(AppRoutesName.forgotPwdPage);
                          },
                          child: const Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                              color: Color(0xFFF6B300),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                        ],
                      ),
                  ),
                      const SizedBox(height: 8),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF6B300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          onPressed:_isRunning? null : () async {
                            setState(() {
                              _isRunning=true;
                            });
                            if (_loginKey.currentState!.validate()) {
                              print(emailController.text)
;                              await AuthApi().loginRequest(context,emailController.text, passwordController.text,);
                            }
                            setState(() {
                              _isRunning=false;
                            });
                          },
                          //onPressed: () {Navigator.of(context).pushNamed(AppRoutesName.accueilPage);},
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
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutesName.signUpPage);

                            },
                            child: const Text(
                              "Inscrivez-vous",
                              style: TextStyle(
                                color: Color(0xFFF6B300),
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
      ),
    );
  }

  static Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  static Widget _inputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3D2A3A),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller,{required String hint, bool isPassword = false, bool isPwdVisible = false}) {

    return TextField(
      controller: controller,

      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: isPassword ? const Icon(Icons.lock_outline_rounded) : Icon(Icons.email_outlined),
        prefixIconColor: Color(0xFF3D2A3A),
        suffixIcon:isPassword ? IconButton(
           onPressed: (){
             setState(() {
               isPwdVisible = !isPwdVisible;
             });
           }, icon: isPwdVisible? Icon(Icons.visibility):Icon(Icons.visibility_off)
       )
       :
       null,

        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5EEF3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

}
