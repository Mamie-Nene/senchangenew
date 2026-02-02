
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TransformationFormatMethods{
  // fonction pour fommatter une valeur en devise ex 1000 en 1 000 et le mettre come vaeur sur input
  static void formatCurrency(String value, TextEditingController controller) {
    var currencyFormat = NumberFormat('#,###', 'fr_FR'); // Format français

    // Supprimer les caractères non numériques sauf le point
    String sanitizedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    // Vérifier et formater le nombre
    double? parsedValue = double.tryParse(sanitizedValue);

    // Si la valeur est un nombre valide
    if (parsedValue != null) {
      // Appliquer le format de séparation des milliers tout en gardant les décimales
      String formattedValue = currencyFormat.format(parsedValue);

      // Mettre à jour le champ de texte avec la valeur formatée
      controller.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } else {
      // Si la valeur n'est pas un nombre valide, on ne fait rien
      controller.value = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
  }

  // fonction pour fommatter une valeur en devise ex 1000 en 1 000
  static String formatCurrencyAmount(String value) {
    var currencyFormat = NumberFormat('#,###', 'fr_FR'); // Format français

    // Supprimer les caractères non numériques sauf le point
    String sanitizedValue = value.replaceAll(RegExp(r'[^0-9.]'), '');

    // Vérifier et formater le nombre
    double? parsedValue = double.tryParse(sanitizedValue);

    // Si la valeur est un nombre valide
    if (parsedValue != null) {
      // Appliquer le format de séparation des milliers tout en gardant les décimales
      String formattedValue = currencyFormat.format(parsedValue);

      // Mettre à jour le champ de texte avec la valeur formatée
      return formattedValue;
    } else {
      // Si la valeur n'est pas un nombre valide, on ne fait rien
      return "";
    }
  }

  // fonction pour tronquer un texte
  static String truncateWithEllipsis(int maxLength, String text) {
    return (text.length <= maxLength)
        ? text
        : '${text.substring(0, maxLength)}...';
  }

  // fonction pour formatter les statuts de transaction
  static String formatTransactionStatus(status) {
    // WAITING_OTP
    if (status == "WAITING_OTP") {
      return "en attente";
    }
    if (status == "INIT") {
      return "initialisée";
    }
    if (status == "PENDING") {
      return "en cours";
    }
    if (status == "ACCEPTED") {
      return "acceptée";
    }
    if (status == "REJECTED") {
      return "rejetée";
    }
    return "";
  }

  // fonction pour gerer la devise du montant initil sur l'historique
  static String formatTransationInitCurrency(amountInit, type) {
    if (type == "ACHAT" || type == "VENTE") {
      return "$amountInit USDT";
    }
    if (type == "VENTE_DOLLAR") {
      return "$amountInit \$";
    }
    if (type == "VENTE_EURO") {
      return "$amountInit €";
    }
    if (type == "ACHAT_DOLLAR" || type == "ACHAT_EURO") {
      return "$amountInit FCFA";
    }
    return "";
  }

  // fonction pour gerer la devise du montant coonverti sur details echange
  static String formatExchangeAmountCurrency(amount, type) {
    if (type == "VENTE_DOLLAR" || type == "VENTE_EURO") {
      return "$amount FCFA";
    }
    if (type == "ACHAT_DOLLAR") {
      return "$amount \$";
    }
    if (type == "ACHAT_EURO") {
      return "$amount €";
    }
    return "";
  }

  static String formatDateInFrench(String dateString) {
    try {
      // Initialise les données locales
      initializeDateFormatting('fr_FR', null);

      // Parse la date depuis la chaîne
      DateTime parsedDate = DateFormat("dd-MM-yyyy HH:mm:ss").parse(dateString);

      // Formate la date en français
      return DateFormat("dd MMMM yyyy HH:mm", 'fr_FR').format(parsedDate);
    } catch (e) {
      return "Date invalide";
    }
  }

  static String timeAgo(String dateTransaction) {
    DateTime transactionDate = DateFormat(
      "dd-MM-yyyy HH:mm:ss",
    ).parse(dateTransaction);
    Duration difference = DateTime.now().difference(transactionDate);

    String pluralize(int value, String singular, String plural) {
      return "$value ${value == 1 ? singular : plural}";
    }

    if (difference.inSeconds < 60) {
      // return "il y a ${pluralize(difference.inSeconds, "seconde", "secondes")}";
      return "à l'instant";
    } else if (difference.inMinutes < 60) {
      return "il y a ${pluralize(difference.inMinutes, "minute", "minutes")}";
    } else if (difference.inHours < 24) {
      return "il y a ${pluralize(difference.inHours, "heure", "heures")}";
    } else if (difference.inDays < 30) {
      return "il y a ${pluralize(difference.inDays, "jour", "jours")}";
    } else {
      // return DateFormat("dd MMM yyyy").format(transactionDate);
      return formatDateInFrench(dateTransaction);
    }
  }


}