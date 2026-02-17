import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class AppAuthHeader extends StatefulWidget {
  final String title;
  final String subtitle;
  const AppAuthHeader({super.key, required this.title, required this.subtitle});

  @override
  State<AppAuthHeader> createState() => _AppAuthHeaderState();
}

class _AppAuthHeaderState extends State<AppAuthHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       /* //logo
        Image.asset(AppImages.APP_LOGO2, height:AppDimensions.h80(context)),
        //subtitle
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(AppText.AUTH_SUBTITLE_TEXT,
            style: TextStyle(fontSize: AppDimensions().responsiveFont(context,18), color: AppColors.textGrisColor),
            textAlign: TextAlign.center,
          ),
        ),

        */

        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.mainAppColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              const Text(AppText.AUTH_TITLE_TEXT,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

         Text(widget.subtitle,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF3D2A3A),
          ),
        ),

        const SizedBox(height: 22),
      ],
    );
  }
}
