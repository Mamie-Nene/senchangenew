import 'package:senchange/src/presentation/pages/new_pages/home_pages/new_home_screen.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

class OperationCardLocalData{
  List<ActionButton> actions = [
    ActionButton(
      icon: Icons.shopping_bag_outlined,
      label: "Achat",
      firstGradientColor:  Color(0xFFFDE047), // yellow-300
      secondGradientColor: Color(0xFFFACC15), // yellow-400
      boxIconColor:  Color(0xFFF59E0B).withOpacity(0.8), // yellow-500/80
      iconColor: const Color(0xFF78350F), // yellow-900,
      route:AppRoutesName.acheterPage
    ),
    ActionButton(
      icon: Icons.local_offer_outlined,
      label: "Vente",
      firstGradientColor:    Color(0xFFFBCFE8), // pink-200
      secondGradientColor: Color(0xFFF9A8D4), // pink-300
      boxIconColor: const Color(0xFFF472B6).withOpacity(0.8), // pink-400/80,
      iconColor: const Color(0xFF9D174D), // pink-800,
      route:AppRoutesName.vendrePage
    ),
    ActionButton(
      icon: Icons.refresh,
      label: "Échange",
      firstGradientColor:    Color(0xFF6EE7B7), // emerald-300
      secondGradientColor:  Color(0xFF4ADE80), // green-400
      boxIconColor: const Color(0xFF10B981).withOpacity(0.8), // emerald-500/80,
      iconColor: const Color(0xFF064E3B), // emerald-900,
      route:AppRoutesName.echangePage
    ),
    ActionButton(
      icon: Icons.account_balance_wallet_outlined,
      label: "Mes wallets",
      firstGradientColor:  Color(0xFFD9F99D), // lime-200
      secondGradientColor:  Color(0xFFFEF08A), // yellow-200
      boxIconColor: const Color(0xFF84CC16).withOpacity(0.8), // lime-500/80,
      iconColor: const Color(0xFF3F6212), // lime-800,
      route:AppRoutesName.walletsPage
    ),
  ];

  List<String>iconUrls=["buy.png","exchange-rate.png","cryptocurrency.png","wallet.png"] ;
  List<String>labels=["Achat","Echange","Vente","Portefeuilles"] ;

  List<Color>backgroundColors=[AppColors.orangeColor, const Color.fromARGB(255, 100, 235, 105,),const Color.fromARGB(255, 214, 104, 181,),const Color.fromARGB(255, 227, 230, 86,),] ;
  List<IconData>icons=[Icons.shopping_bag,Icons.currency_exchange,Icons.sell,Icons.account_balance_wallet,] ;

  List<Color>linearTopColors=[AppColors.jauneClairColor,AppColors.vertClairColor,AppColors.roseClairColor,AppColors.jauneClairColor] ;
  List<Color>linearBottomColors=[AppColors.jauneColor,AppColors.vertColor,AppColors.roseColor,AppColors.jauneColor] ;

  List<String>destinations=[AppRoutesName.acheterPage,AppRoutesName.echangePage,AppRoutesName.vendrePage,AppRoutesName.walletsPage ];

  List mockHistorique = List.filled(8, const {
    "blockchainName": "Bitcoin",
    "transactionId": "6775e0eb-e7cf-40fc-bbac-03e776192f15",
    "amountChange": 618.0,
    "amountInit": 1.0,
    "dateTransaction": "11-04-2025 11:46:20",
    "typeTransaction": "ACHAT",
    "statusTransaction": "INIT",
  });


}
const currencyFlags = {
  "XOF": "🇸🇳",
  "USD": "🇺🇸",
  "USDT": "💵",
  "USDC": "💲",
};