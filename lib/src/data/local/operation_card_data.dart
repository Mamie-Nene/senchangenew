import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

class OperationCardLocalData{

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