import 'package:flutter/material.dart';
import 'package:senchange/src/domain/NewTransactionEntity.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';

class TransactionLocalData{

  List<NewTransactionEntity> transactions = [

    NewTransactionEntity(
      transaction_type: "buy",
      status: "completed",
      to_amount:62.05500000,
      from_amount: 35000.00000000,
      from_currency: "XOF",
      to_currency: "USDT",
      created_at: "2026-02-18T23:20:38.528172+00:00",
      blockchain: "BEP20",
      txid:"0x9af0574c7049dca88e488478e58d9b74247995f713255c1cea61f5a12db0bad0",
      fee_amount: 350.00000000,
      reference_code: "SEN-2331CDB3-20260105",
      payment_method: "wave",
      wallet_address: '0xbff10a075ed235c48c466202468004be915c07fb',
      phone_number: '771234567',
      exchange_rate: 0.00177300,

    ),

    NewTransactionEntity(
      transaction_type: "sell",
      status: "Échouée",
      to_amount:17.573,
      from_amount: 10000,
      from_currency: "XOF",
      to_currency: "USDT",
      created_at: "2026-02-18T23:20:38.528172+00:00",
      blockchain: "BEP20",
      txid:"0x9af0574c7049dca88e488478e58d9b74247995f713255c1cea61f5a12db0bad0",
      fee_amount: 100,
      reference_code: "SEN-2331CDB3-20260105",
      payment_method: "Wave",
      wallet_address: '',
      phone_number: '771234567',
      exchange_rate: 00.00,
    ),
  ];

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