import 'package:flutter/material.dart';

import '/src/utils/api/api_url.dart';
import '/src/services/open_link_service.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class InfosJuridiques extends StatefulWidget {
  const InfosJuridiques({super.key});

  @override
  State<InfosJuridiques> createState() => _InfosJuridiquesState();
}

class _InfosJuridiquesState extends State<InfosJuridiques> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(backgroundColor: AppColors.bgColor, title: Text("Infos juridiques")),
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
                      "Conditions générales d'utilisation",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(Icons.person, color: AppColors.orangeColor),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.orangeColor),
                    onTap: () {
                      OpenLinkService.openExternalLink(ApiUrl().senChangeCGULink,
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Politique de confidentialité",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(Icons.lock, color: AppColors.orangeColor),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.orangeColor),
                    onTap: () {OpenLinkService.openExternalLink(ApiUrl().confidentialityLink);},
                  ),
                  ListTile(
                    title: Text(
                      "Mentions légales",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(Icons.security, color: AppColors.orangeColor),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.orangeColor),
                    onTap: () {OpenLinkService.openExternalLink(ApiUrl().mentionLegalesLink);},
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
