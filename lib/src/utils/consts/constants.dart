class Constants {
  //regex pour la validation de l'email
  static const String emailPattern =
      r'(^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';

  static RegExp emailRegExp = RegExp(emailPattern);

  //regex pour la validation du numero de telephone
  static const String phonePattern = r'(^(77|76|75|78|70)[0-9]{7}$)';
  static RegExp phoneRegExp = RegExp(phonePattern);



  static const String passwordPattern = r'(^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).+$)';
  static RegExp passwordRegExp = RegExp(passwordPattern);


  static const String appNameForHeaders= "mobile-senchange";
  static const String whatsapppSupportNumber = "+221781881785";

  static const String whatsappSupportMsg = "Salut, j’utilise votre application Senchange et j’aurais besoin d’échanger avec le support. Merci !";
  static const String statutTransactionEnCours = "WAITING_OTP";

}