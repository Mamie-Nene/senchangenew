import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nomCompletController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B3B5B),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -40,
              left: -40,
              child:
              _circle(120, Colors.orange.withOpacity(0.25)),
            ),
            Positioned(
              bottom: 40,
              right: -30,
              child:
              _circle(140, Colors.orange.withOpacity(0.20)),
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
                      // Header
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
                              "Créer un compte",
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
                        "Inscription",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3D2A3A),
                        ),
                      ),

                      const SizedBox(height: 22),

                      _inputLabel("Nom Complet"),
                      const SizedBox(height: 8),
                      _inputField(controller: nomCompletController,hint:"Votre nom complet",iconData: Icon(Icons.person),),

                      const SizedBox(height: 16),

                      _inputLabel("Nom d'utilisateur",),
                      const SizedBox(height: 8),
                      _inputField(controller: usernameController,hint:"user1",iconData: Icon(Icons.verified_user_outlined),),

                      const SizedBox(height: 16),

                      _inputLabel("Email"),
                      const SizedBox(height: 8),
                      _inputField(controller: emailController,hint:"vous@exemple.com",iconData: Icon(Icons.email_outlined)),

                      const SizedBox(height: 16),

                      _inputLabel("Téléphone"),
                      const SizedBox(height: 8),
                      _inputField(controller: telephoneController,hint: "770000000",iconData: Icon(Icons.phone)),

                      const SizedBox(height: 16),

                      _inputLabel("Mot de passe"),
                      const SizedBox(height: 8),
                      _inputField(
                        controller: passwordController, hint:"..........",iconData: Icon(Icons.email_outlined),
                        isPassword: true,
                      ),

                      const SizedBox(height: 16),

                      _inputLabel("Confirmer mot de passe"),
                      const SizedBox(height: 8),
                      _inputField(
                        controller: confirmPasswordController,hint:"..........",iconData: Icon(Icons.email_outlined),
                        isPassword: true,
                      ),

                      const SizedBox(height: 22),

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
                          onPressed: () {
                            // TODO: signup logic
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
                            child: const Text(
                              "Se connecter",
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

   Widget _inputField({
     required String hint,
    required TextEditingController controller,
     required Icon iconData,
    bool isPassword = false,bool isPwdVisible = false
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: isPassword ? const Icon(Icons.lock_outline_rounded) : iconData,
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
