

import '/src/utils/consts/constants.dart';

class ApiUrl{

  //  ---------------------- Const Var --------------------

  //static const String baseUrl = "http://212.227.78.64:9898/api/v1"; // Preprod
  static const String baseUrl='https://senchange.com:7443/api/v1'; // Prod
  //static const String stompWSUrlAvant='ws://87.106.141.223:8086/socket/websocket';  //wss for more security
  static const String stompWSUrl='wss://senchange.com:8086/socket/websocket';

  //  ------------------------- AUTH --------------------

  String loginUrl="$baseUrl/login";

  String signUpUrl="$baseUrl/user/register";

  String updateUserUrl="$baseUrl/user/update-user";

  String resetPasswordUrl="$baseUrl/user/reset-password";

  String changePasswordUrl="$baseUrl/user/change-password";

  String loginByOtpUrl="$baseUrl/login-by-otp";

  String activeCompteByOtpURL="$baseUrl/user/activate-by-otp";

  String forgotPwdWithOtpUrl="$baseUrl/user/verify-otp-for-mobile";

  String sendOtpForPasswordForgotten="$baseUrl/user/send-for-password";

  String sendOtpForDevice="$baseUrl/user/send-otp-device";

  String activateDevice="$baseUrl/user/activate-devices";

  String desactiverCompte="$baseUrl/deactivate-account";


  // --------------- Transaction ----------------

  String submitTransactionWithOtpURL="$baseUrl/transaction-change/submit-otp";

  String getHistoriqueTransaction="$baseUrl/transaction-change/all-by-user";

  String getAllHistoriqueTransaction="$baseUrl/transaction-change/all";

  String getTransactionStatus="$baseUrl/transaction-change";

  String calculAmount="$baseUrl/transaction-change/calculate-amount";

  String saveTransaction="$baseUrl/transaction-change/create";

  String relancerTransaction="$baseUrl/transaction-change/relaunch-otp";

  String annulerTransaction="$baseUrl/transaction-change/cancel";

  // ------------------  Wallet --------------------------

  String createWallet="$baseUrl/wallet/create";

  String getSenChangeWallet="$baseUrl/wallet/back-office/type";

  String getListWallet="$baseUrl/wallet/list";

  String archiveWallet="$baseUrl/wallet/change-state";

  String updateWallet="$baseUrl/wallet/update";

  // ------------------ reclamations -----------------

  String addReclamation="$baseUrl/reclamations";

  // --------------- settings -----------

  String changeParametre="$baseUrl/preference/change";

  // ---------------- external link ------------------

  String linkedinLink="https://www.linkedin.com/company/senchange/";

  String XLink="https://x.com/sen_change?t=W2my6Nb6_Ovm480E_PX6bQ&s=09";

  String tiktokLink="https://www.tiktok.com/@senchange99?_t=ZN-8uz1Gl9754I&_r=1";

  String mentionLegalesLink="https://senchange.com/mentions_legales";

  String confidentialityLink="https://senchange.com/politique_confidentialite";

  String senChangeCGULink="https://senchange.com/cgu";

  String whatsAppContactUsUrl="https://wa.me/${Constants.whatsapppSupportNumber}?text=${Constants.whatsappSupportMsg}";

  String downloadAppUrl="https://wa.me/?text=Télécharger%20l'application%20Senchange";

  String waveLink="https://pay.wave.com/m/M_sn_b7DX1A4PwOfs/c/sn/";

  String waveLinkAvant="https://pay.wave.com/m/M_poOCEum2faE3";


}