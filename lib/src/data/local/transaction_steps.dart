import 'package:flutter/material.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';

class TransactionLocalData{

List<Map<String, dynamic>> steps = [
  {"title": "Otp validé", "icon": Icons.check, "color": AppColors.otpWaitingColor},
  {"title": "Initialisée", "icon": Icons.check, "color": AppColors.transactionInitColor},
  {"title": "En cours", "icon": Icons.check, "color": AppColors.transactionPendingColor},
  {"title": "Acceptée", "icon": Icons.check, "color": AppColors.transactionAcceptedColor},
];


List fromCurrencies = [
  {"label": "Dollar", "iconUrl": AppImages.US_FLAG_IMAGES},
  {"label": "Euro", "iconUrl": AppImages.UE_FLAG_IMAGES},
  {"label": "FCFA", "iconUrl": AppImages.SN_FLAG_IMAGES},
];

List toCurrencies = [
  {"label": "FCFA", "iconUrl": AppImages.SN_FLAG_IMAGES},
];
final mobileMoneys = [
  {
    "label": "Wave",
    "iconUrl": AppImages.WAVE_ICON,
    "operator": "WAVE",
  },
  {
    "label": "Orange Money",
    "iconUrl":AppImages.OM_ICON ,
    "operator": "ORANGE_MONEY",
  },
  {
    "label": "Yas",
    "iconUrl": AppImages.YAS_ICON,
    "operator": "FREE_MONEY",
  },
];



}