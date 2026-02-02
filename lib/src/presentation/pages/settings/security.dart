
import 'package:flutter/material.dart';
import '/src/data/remote/security/security_api.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';

import '/src/methods/storage_management.dart';


class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  bool isAuthTwoFactorActive = false;
  bool isPasswordRotationActive = false;

  // recuperer les infso dans le shared preferences
  getUserInfos() async {
    String? mfa = await StorageManagement.getStorage("mfa");
    String? rotation = await StorageManagement.getStorage("rotation");

    // set du valeur par defaut de mfa
    if (mfa != null && mfa == "true") {
      setState(() {
        isAuthTwoFactorActive = true;
      });
    } else {
      setState(() {
        isAuthTwoFactorActive = false;
      });
    }

    // set du valeur par defaut de rotation
    if (rotation != null && rotation == "true") {
      setState(() {
        isPasswordRotationActive = true;
      });
    } else {
      setState(() {
        isPasswordRotationActive = false;
      });
    }
  }

 

  @override
  void initState() {
    getUserInfos();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(backgroundColor: AppColors.bgColor, title: Text("Sécurité")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    title:  Text(
                      "Authentification Two-Factor",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(Icons.lock, color: AppColors.orangeColor),
                    trailing: Switch(
                      value: isAuthTwoFactorActive,
                      onChanged: (value) {
                        setState(() {
                          isAuthTwoFactorActive = value;
                        });
                        SecurityApi().changeParams("MFA");
                      },
                      activeColor: AppColors.orangeColor,
                    ),
                  ),
                  ListTile(
                    title:  Text(
                      "Rotation mot de passe",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      Icons.rotate_left_outlined,
                      color: AppColors.orangeColor,
                    ),
                    trailing: Switch(
                      value: isPasswordRotationActive,
                      onChanged: (value) {
                        setState(() {
                          isPasswordRotationActive = value;
                        });

                        SecurityApi().changeParams("ROTATION_PASSWORD");
                      },
                      activeColor: AppColors.orangeColor,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.passwordResetPage);
                    },
                    child: ListTile(
                      title: Text(
                        "Modifier mon mot de passe",
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(Icons.password, color: AppColors.orangeColor),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
