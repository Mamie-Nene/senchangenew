

import '/src/utils/consts/constants.dart';

class ApiUrl{

  //  ---------------------- Const Var --------------------

  static const String baseUrl='https://xakfjbfsigtjibefcpgc.supabase.co/'; // Prod
  static const String apiKey="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhha2ZqYmZzaWd0amliZWZjcGdjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUzNzc5NzcsImV4cCI6MjA4MDk1Mzk3N30.oCItXwI6RzJjORh68ZQfj2F4WXvlmzHbnVK330dmip0"; // Prod

  static const String stompWSUrl='wss://newsenchange.com:8086/socket/websocket';

  //  ------------------------- AUTH --------------------

  String loginUrl="$baseUrl/auth/v1/token?grant_type=password";

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

  String getHistoriqueTransaction="https://xakfjbfsigtjibefcpgc.supabase.co/rest/v1/transactions?select=*&user_id=eq.41d07550-b58a-4fbc-87e1-5c490f8a854d&order=created_at.desc&offset=0&limit=5";

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

  String linkedinLink="https://www.linkedin.com/company/newsenchange/";

  String XLink="https://x.com/sen_change?t=W2my6Nb6_Ovm480E_PX6bQ&s=09";

  String tiktokLink="https://www.tiktok.com/@senchange99?_t=ZN-8uz1Gl9754I&_r=1";

  String mentionLegalesLink="https://senchange.com/mentions_legales";

  String confidentialityLink="https://senchange.com/politique_confidentialite";

  String senChangeCGULink="https://senchange.com/cgu";

  String whatsAppContactUsUrl="https://wa.me/${Constants.whatsapppSupportNumber}?text=${Constants.whatsappSupportMsg}";

  String downloadAppUrl="https://wa.me/?text=Télécharger%20l'application%20Senchange";

  String waveLink="https://pay.wave.com/m/M_sn_b7DX1A4PwOfs/c/sn/";

  String waveLinkAvant="https://pay.wave.com/m/M_poOCEum2faE3";

  //modou

  String signup="$baseUrl/auth/v1/signup";

  String login="$baseUrl/auth/v1/token?grant_type=password";

  String logout="$baseUrl/auth/v1/logout";

  String buy="$baseUrl/buy";

  String sell="$baseUrl/sell";

  String transaction="$baseUrl/transactions";

  String exchangeRate="$baseUrl/exchange_rates";

  String paymentMethods="$baseUrl/payment_methods";

  String blockchainTypes="$baseUrl/blockchain_types";

  String senchangeWallets="$baseUrl/senchange_wallets";

  String userWalletsAddresses="$baseUrl/wallet_addresses";

  String profileUser="$baseUrl/profiles";




}