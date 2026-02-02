import 'package:flutter/cupertino.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class AppAuthHeader extends StatefulWidget {
  const AppAuthHeader({super.key});

  @override
  State<AppAuthHeader> createState() => _AppAuthHeaderState();
}

class _AppAuthHeaderState extends State<AppAuthHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //logo
        Image.asset(AppImages.APP_LOGO2, height:AppDimensions.h80(context)),
        //subtitle
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(AppText.AUTH_SUBTITLE_TEXT,
            style: TextStyle(fontSize: AppDimensions().responsiveFont(context,18), color: AppColors.textGrisColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
