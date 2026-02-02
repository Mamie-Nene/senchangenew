import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/src/methods/response_messages.dart';

class OpenLinkService {

  static Future<void> openExternalLink(String link, {BuildContext? context}) async {
    final Uri url = Uri.parse(link);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context != null && context.mounted) {
        ResponseMessageService.showErrorToast(context, "Impossible d'ouvrir le lien");
      }
    }
  }



}