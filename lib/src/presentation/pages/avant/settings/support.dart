import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/src/utils/api/api_url.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

import '/src/utils/consts/constants.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/services/utils.service.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final Uri whatsappWebUrl = Uri.parse(ApiUrl().whatsAppContactUsUrl,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(backgroundColor: AppColors.bgColor, title: Text("Aide & Support")),
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
                  GestureDetector(
                    onTap: () async {
                      await UtilsService.startPhoneCall(Constants.whatsapppSupportNumber);
                    },
                    child: ListTile(
                      title: Text(
                        "Appeler le service client",
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(Icons.support_agent, color: AppColors.orangeColor),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Contacter par WhatsApp",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: AppColors.orangeColor,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.orangeColor),
                    onTap: () async {
                      if (await canLaunchUrl(whatsappWebUrl)) {
                        await launchUrl(
                          whatsappWebUrl,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        print("Impossible d'ouvrir whatsapp");
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Faire une réclamation",
                      style: TextStyle(
                        fontSize: AppDimensions().responsiveFont(context,16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Icon(Icons.question_answer, color: AppColors.orangeColor),
                    trailing: Icon(Icons.arrow_forward_ios, color: AppColors.orangeColor),
                    onTap: () async {
                      Navigator.of(context).pushNamed(AppRoutesName.reclamationPage);
                    },
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