import 'package:flutter/material.dart';

import '/src/utils/api/api_url.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import 'package:url_launcher/url_launcher.dart';

class Share extends StatefulWidget {
  const Share({super.key});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
  final Uri whatsappWebUrl = Uri.parse(ApiUrl().downloadAppUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(backgroundColor: AppColors.bgColor, title: Text("Partager")),
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
                      if (await canLaunchUrl(whatsappWebUrl)) {
                        await launchUrl(
                          whatsappWebUrl,
                          mode: LaunchMode.externalApplication,
                        );
                      } else {
                        print("Impossible d'ouvrir whatsapp");
                      }
                    },
                    child: ListTile(
                      title: Text(
                        "Partager l'application sur WhatsApp",
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(Icons.share, color: AppColors.orangeColor),
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
