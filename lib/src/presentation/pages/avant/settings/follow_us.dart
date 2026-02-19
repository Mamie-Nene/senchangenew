
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/src/utils/api/api_url.dart';

import '/src/services/open_link_service.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class FollowUs extends StatefulWidget {
  const FollowUs({super.key});

  @override
  State<FollowUs> createState() => _FollowUsState();
}

class _FollowUsState extends State<FollowUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppBar(backgroundColor: AppColors.bgColor, title: Text("Nous suivre")),

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
                    onTap: () {OpenLinkService.openExternalLink(ApiUrl().linkedinLink,);
                    },
                    child:  ListTile(
                      title: Text(
                        "Sur Linkedin",
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(
                        FontAwesomeIcons.linkedin,
                        color: AppColors.orangeColor,
                      ),
                      // trailing: Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: AppColors.orangeColor,
                      // ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {OpenLinkService.openExternalLink(ApiUrl().XLink);},
                    child: ListTile(
                      title: Text(
                        "Sur X",
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(FontAwesomeIcons.x, color: AppColors.orangeColor),

                    ),
                  ),
                  GestureDetector(
                    onTap: () {OpenLinkService.openExternalLink(ApiUrl().tiktokLink);},
                    child: ListTile(
                      title: Text(
                        "Sur Tiktok",
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(
                        FontAwesomeIcons.tiktok,
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
