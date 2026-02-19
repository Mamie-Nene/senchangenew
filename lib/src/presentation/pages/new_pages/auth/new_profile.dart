import 'package:flutter/material.dart';
import 'package:senchange/src/utils/consts/app_specifications/allDirectories.dart';
import 'package:senchange/src/utils/consts/routes/app_routes_name.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainAppColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        elevation: 0,
        title: const Text("Profil"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFFF6B300),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),

            const SizedBox(height: 16),

            _infoTile("Nom", "Ba"),
            _infoTile("Prénom", "Mame Nene"),
            _infoTile("Email", "email@example.com"),
            _infoTile("Téléphone", "+221 77 000 00 00"),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF6B300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutesName.loginPage);
                },
                child: const Text(
                  "Se déconnecter",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.black54)),
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, color: Color(0xFF3D2A3A))),
        ],
      ),
    );
  }
}
