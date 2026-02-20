import 'package:flutter/material.dart';
import 'package:senchange/src/presentation/pages/avant/settings/infos_juridiques.dart';
import 'package:senchange/src/presentation/pages/avant/settings/security.dart';
import 'package:senchange/src/presentation/pages/new_pages/auth/new_forgot_pwd.dart';
import 'package:senchange/src/presentation/pages/new_pages/auth/new_login.dart';
import 'package:senchange/src/presentation/pages/new_pages/auth/new_password_recover.dart';
import 'package:senchange/src/presentation/pages/new_pages/auth/new_profile.dart';
import 'package:senchange/src/presentation/pages/new_pages/auth/new_signup.dart';
import 'package:senchange/src/presentation/pages/new_pages/home_pages/splash_screen.dart';
import 'package:senchange/src/presentation/pages/new_pages/operation/achat_new_new.dart';
import 'package:senchange/src/presentation/pages/new_pages/operation/buy_or_sell_page.dart';
import 'package:senchange/src/presentation/pages/new_pages/operation/currency_exchange.dart';
import 'package:senchange/src/presentation/pages/new_pages/operation/new_vente_screen.dart';

import '/src/presentation/pages/avant/auth/parametres.dart';
import '/src/presentation/pages/avant/auth/update_password.dart';
import '/src/presentation/pages/avant/auth/verification_code.dart';
import '/src/presentation/pages/avant/notification/notification_page.dart';
import '/src/presentation/pages/avant/operation_part/achat/achat_details.dart';
import '/src/presentation/pages/avant/operation_part/vendre/vente_details.dart';
import '/src/presentation/pages/avant/settings/follow_us.dart';
import '/src/presentation/pages/avant/settings/reclamation.dart';
import '/src/presentation/pages/avant/settings/share.dart';
import '/src/presentation/pages/avant/settings/support.dart';
import '../../presentation/pages/new_pages/operation/add_wallet.dart';
import '/src/presentation/pages/avant/wallet/wallet_details.dart';
import '../../presentation/pages/new_pages/operation/wallet.dart';

import '../../presentation/pages/new_pages/home_pages/new_home_screen.dart';
import '../../presentation/pages/new_pages/operation/detailTransaction_new.dart';
import '../../presentation/pages/new_pages/operation/new_transaction.dart';
import '../../presentation/pages/new_pages/home_pages/introduction_page.dart';

import '/src/presentation/pages/avant/add_mobile_money_account.dart';

import '/src/presentation/pages/utils_pages/all_directories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings, bool isFirstTime)
  {
    final args = settings.arguments;

    switch (settings.name){

      //   -------------------- Home Pages ------------------------------

      case AppRoutesName.splashFirstPage:
        return MaterialPageRoute( builder: (context) =>   Splashscreen(isFirstTime: isFirstTime));

      case AppRoutesName.introductionPage:
        return MaterialPageRoute( builder: (context) =>   const IntroductionPage());

      case AppRoutesName.accueilPage:
        return MaterialPageRoute( builder: (context) =>  const HomeScreen());
        ///return MaterialPageRoute( builder: (context) =>  const Accueil());

    //   --------------------  AUTH Pages ------------------------------

      case AppRoutesName.loginPage:
        return MaterialPageRoute( builder: (context) =>  const LoginScreen());
       // return MaterialPageRoute( builder: (context) =>  const LoginPage());

      case AppRoutesName.signUpPage:
      return MaterialPageRoute( builder: (context) =>  const SignupScreen());
      //return MaterialPageRoute( builder: (context) =>  const SignupPage());

      case AppRoutesName.passwordResetPage:
      return MaterialPageRoute( builder: (context) =>  const NewPasswordScreen());
      //return MaterialPageRoute( builder: (context) =>  const ResetPassword());

      case AppRoutesName.updatePwdPage:
        final args = settings.arguments;
        var email= (args as Map)["email"].toString();

        return MaterialPageRoute( builder: (context) =>   UpdatePassword(email: email));

      case AppRoutesName.forgotPwdPage:
      return MaterialPageRoute( builder: (context) =>  const ForgotPasswordScreen());
      //return MaterialPageRoute( builder: (context) =>  const ForgotPassword());

      case AppRoutesName.updateProfilPage:
        return MaterialPageRoute( builder: (context) =>  const  ProfileScreen());
       // return MaterialPageRoute( builder: (context) =>  const  UpdateProfil());

    //   --------------------  OTP Pages ------------------------------

      case AppRoutesName.verificationCodeOtpPage:
       final args = settings.arguments;
        var action= (args as Map)["action"].toString();
        var email= (args)["email"].toString();

        return MaterialPageRoute( builder: (context) =>  VerificationCode(action: action, email: email));

      case AppRoutesName.verificationCodeOtpPageWithAllArgs:
        final args = settings.arguments;
        var action= (args as Map)["action"].toString();
        var email= (args)["email"].toString();
        var montant= (args)["montant"].toString();
        var paymentMethod= (args)["paymentMethod"].toString();

        return MaterialPageRoute( builder: (context) =>  VerificationCode(action: action, email: email, montant:montant, paymentMethod:paymentMethod ));

      case AppRoutesName.verificationCodeOtpPageWith3Args:
        final args = settings.arguments;
        var action= (args as Map)["action"].toString();
        var email= (args)["email"].toString();
        var montant= (args)["montant"].toString();

        return MaterialPageRoute( builder: (context) =>  VerificationCode(action: action, email: email, montant:montant ));

    //   --------------------  Wallets Pages ------------------------------

      case AppRoutesName.walletsPage:
        return MaterialPageRoute( builder: (context) => const GestionWallet());
        //return MaterialPageRoute( builder: (context) => const WalletsPage());

      case AppRoutesName.walletsDetailsPage:
        final args = settings.arguments;

        var nameWallet= (args as Map)["nameWallet"].toString();
        var address= (args as Map)["address"].toString();
        var blockChainType= (args as Map)["blockChainType"].toString();
        var id = (args as Map)["id"].toString();

        return MaterialPageRoute( builder: (context) => WalletsDetailsPage(nameWallet: nameWallet, address: address, blockChainType:blockChainType, id:id ));

      case AppRoutesName.addWalletPage:
        return MaterialPageRoute( builder: (context) => const AddWallet());

      case AppRoutesName.addMobileMoneyAccountPage:
        return MaterialPageRoute( builder: (context) => const AddMobileMoneyAccount());

    //   --------------------  Operations Pages ------------------------------

      case AppRoutesName.buyOrSellPage:
        return MaterialPageRoute(  builder: (context) =>  BuyOrSellPage());

      case AppRoutesName.acheterPage:
        return MaterialPageRoute(  builder: (context) =>  AchatPageNewNew());
       // return MaterialPageRoute(  builder: (context) =>  AchatScreen());//2nd
       // return MaterialPageRoute(  builder: (context) =>  AcheterScreen());///1st

      case AppRoutesName.transactiionOperationPage:
       return MaterialPageRoute(  builder: (context) => TransactionsScreen());

      case AppRoutesName.detailTransactionPage:
        final args = settings.arguments;
        var transaction = (args as Map)["transaction"];
        return MaterialPageRoute(  builder: (context) => TransactionDetailScreen(transaction: transaction));

      case AppRoutesName.achatDetailsPage:
        final args = settings.arguments;
        var transaction = (args as Map)["transaction"];
        return MaterialPageRoute(  builder: (context) => AchatDetails(transaction: transaction));

      case AppRoutesName.venteDetailsPage:
        final args = settings.arguments;
        var transaction = (args as Map)["transaction"];
        return MaterialPageRoute(  builder: (context) => VenteDetails(transaction: transaction));

      case AppRoutesName.vendrePage:
        return MaterialPageRoute(  builder: (context) =>   const SellUsdtScreen());
        //return MaterialPageRoute(  builder: (context) =>   const VendreScreen());

      case AppRoutesName.echangePage:
        return MaterialPageRoute(  builder: (context) =>  const CurrencyConverterPage());
       // return MaterialPageRoute(  builder: (context) =>  const EchangeScreen());

      case AppRoutesName.echangeDetailsPage:
        final args = settings.arguments;
        var transaction = (args as Map)["transaction"];
        return MaterialPageRoute(  builder: (context) => VenteDetails(transaction: transaction));


    //   --------------------  Settings Pages ------------------------------

      case AppRoutesName.supportPage:
        return MaterialPageRoute(  builder: (context) => const Support());

      case AppRoutesName.securityPage:
        return MaterialPageRoute(  builder: (context) => const Security());

      case AppRoutesName.sharePage:
        return MaterialPageRoute(  builder: (context) => const Share());

      case AppRoutesName.followUsPage:
        return MaterialPageRoute(  builder: (context) => const FollowUs());

      case AppRoutesName.infoJuridiquePage:
        return MaterialPageRoute(  builder: (context) => const InfosJuridiques());

      case AppRoutesName.parametrePage:
        return MaterialPageRoute(  builder: (context) => const  Parametres());

      case AppRoutesName.reclamationPage:
        return MaterialPageRoute(  builder: (context) => const  Reclamation());

      case AppRoutesName.notifPage:
        return MaterialPageRoute(  builder: (context) => const  NotificationsPageV2());

      case AppRoutesName.blankPage:
        return MaterialPageRoute(  builder: (context) => const BlankPage());

      default :
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context){return const ErrorScreen();}
    );
  }


}