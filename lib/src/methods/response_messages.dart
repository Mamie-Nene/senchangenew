import 'package:flutter/material.dart';

import '../utils/consts/app_specifications/allDirectories.dart';

class ResponseMessageService {
  static showSuccessToast(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 140, 241, 140),
        content: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF00BA00),
              foregroundColor: Colors.white,
              child: Icon(Icons.check),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                message,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions().responsiveFont(context,16),
                  color: AppColors.textGrisColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showErrorToast(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 241, 152, 96),
        content: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              child: Icon(Icons.close),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                message,
                softWrap: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimensions().responsiveFont(context,16),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  getSnackBarForInformation(){
    return   const SnackBar(
      backgroundColor: Color.fromARGB(255, 243, 200, 230),
      content: Row(
        children: [
          Expanded(
            child: Text(
              AppText.TOKEN_EXPIRATION_INFORMATION_TEXT,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
  getSnackBarForSuccessReturn(BuildContext context,String text ){
    return SnackBar(
      behavior: SnackBarBehavior.floating, // Permet de contrôler la position
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 100, left: 20, right: 20,),
      backgroundColor: Color.fromARGB(255, 140, 241, 140,),
      content: Text(text,
        style: TextStyle(
          fontSize: AppDimensions().responsiveFont(context,16),
          color: AppColors.textGrisColor,
        ),
      ),
    );
  }
}