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


  static const String appNameForHeaders= "mobile-newsenchange";
  static const String whatsapppSupportNumber = "+221781881785";

  static const String whatsappSupportMsg = "Salut, j’utilise votre application Senchange et j’aurais besoin d’échanger avec le support. Merci !";
  static const String statutTransactionEnCours = "WAITING_OTP";

  // new
  static const String waveImageLink = "https://xakfjbfsigtjibefcpgc.supabase.co/storage/v1/object/public/payment-logos/logos/59075c4f-9488-49fc-98c0-74cd58a3ee1d.png";
  static const String omImageLink = "https://xakfjbfsigtjibefcpgc.supabase.co/storage/v1/object/public/payment-logos/logos/5dc4224f-07f8-4888-bb18-d8a43f452fe5.png";

}