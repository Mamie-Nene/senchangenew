import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:senchange/src/services/secure_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import '/src/methods/storage_management.dart';
import '/src/methods/response_messages.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';



class UtilsService {

  // ------------ Function to get token and check his availablity --> return true if token is expired and false otherwise ------------

  static Future<bool> isTokenExpired() async {
    //final token = await SecureStorageService.getToken("access_token");
    final token = await StorageManagement.getStorage('access_token');
    bool hasExpired = JwtDecoder.isExpired(token!);

    return hasExpired;
  }

  // ------------ Function to start phonecall ------------

  static startPhoneCall(String phoneNumber, {BuildContext? context}) async {

    final Uri phoneUri = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
    } else {
      if (context != null && context.mounted) {
        ResponseMessageService.showErrorToast(context, AppText.NOT_ABLE_TO_START_PHONECALL_TEXT);
      }
    }
  }

  // ------------ Function to get transaction color based on his status ------------

  static Color getTransactionColor(String status) {
    switch(status){
      case "WAITING_OTP":
        return AppColors.otpWaitingColor;

      case "INIT":
        return AppColors.transactionInitColor;

      case "PENDING":
        return AppColors.transactionPendingColor;

      case "ACCEPTED":
        return AppColors.transactionAcceptedColor;

      case "REJECTED":
        return AppColors.transactioRejectedColor;
      default :   return const Color(0XFF000000);


    }
  /*  if (status == "WAITING_OTP") {
      return AppColors.otpWaitingColor.withAlpha((0.1 * 255).toInt());
    }
    if (status == "INIT") {
      return AppColors.transactionInitColor.withAlpha((0.1 * 255).toInt());
    }
    if (status == "PENDING") {
      return AppColors.transactionPendingColor.withAlpha((0.1 * 255).toInt());
    }
    if (status == "ACCEPTED") {
      return AppColors.transactionAcceptedColor.withAlpha((0.1 * 255).toInt());
    }
    if (status == "REJECTED") {
      return AppColors.transactioRejectedColor.withAlpha((0.1 * 255).toInt());
    }
    return Color(0XFF000000).withAlpha((0.1 * 255).toInt());*/
  }
  /*// ------------ fonction pour retourner le code couleur suivant le statut de la transaction ------------
  static Color getTransactionLabelColor(status) {
    if (status == "WAITING_OTP") {
      return AppColors.otpWaitingColor;
    }
    if (status == "INIT") {
      return AppColors.transactionInitColor;
    }
    if (status == "PENDING") {
      return AppColors.transactionPendingColor;
    }
    if (status == "ACCEPTED") {
      return Colors.green;
    }
    if (status == "REJECTED") {
      return AppColors.transactioRejectedColor;
    }
    return Colors.black;
  }
*/

  // ------------ Function to get user's device informations ------------

  static Future<dynamic> getDeviceInfo() async {

    final deviceInfoPlugin = DeviceInfoPlugin();

    Map<String, String> deviceInfo = {"version": '', 'nom': ''};

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      debugPrint('Modèle: ${androidInfo.model}');
      debugPrint('Fabricant: ${androidInfo.manufacturer}');
      debugPrint('Version Android: ${androidInfo.version.release}');

      deviceInfo['version'] = "Android${androidInfo.version.release}";

      // check if deviceName is already stored if not create it
      String? deviceName = await StorageManagement.getStorage('deviceName');

      if (deviceName !=null ) {
        deviceInfo['nom'] = deviceName;
      } else {
        String name = androidInfo.model;
        StorageManagement.setStringStorage("deviceName", name.replaceAll(' ', ''));
        deviceInfo['nom'] = name;
      }
    } else if (Platform.isIOS) {

      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;

      debugPrint('Nom de l\'appareil: ${iosInfo.name}');
      debugPrint('Modèle: ${iosInfo.utsname.machine}');
      debugPrint('Version iOS: ${iosInfo.systemVersion}');

      deviceInfo['version'] = "Ios${iosInfo.systemVersion}";
      deviceInfo['nom'] = iosInfo.name;

    }

    return deviceInfo;
  }



}