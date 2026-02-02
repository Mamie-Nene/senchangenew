import 'package:flutter/material.dart';


import '/src/utils/consts/routes/app_routes_name.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed(AppRoutesName.accueilPage),
          child: const Text("Retour à la page d'accueil"),
        ),
      ),
    );
  }
}