import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http/intercepted_http.dart';

import '/src/services/secure_storage_service.dart';
import '/src/methods/response_messages.dart';
import '/src/methods/storage_management.dart';
import '/src/services/token_interceptor.dart';
import '/src/utils/api/api_url.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

class ReclamationApi{
  // fonction pour envoyer la reclamation
  Future saveClaim(BuildContext context,String descriptionController,Map<String, String> selectedType) async {
    final url = Uri.parse(ApiUrl().addReclamation);

   // final token = await SecureStorageService.getToken('access_token');
    final token = await StorageManagement.getStorage('access_token');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Ajout du token ici
    };

    var body = jsonEncode({
      "description": descriptionController,
      "categorie": selectedType['valeur'],
    });


    final http = InterceptedHttp.build(interceptors: [TokenInterceptor()]);
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {

      if (!context.mounted) return ;
        ResponseMessageService.showSuccessToast(context, "Votre réclamation a été envoyée à l'quipe SENCHANGE",);
        Navigator.of(context).pushReplacementNamed(AppRoutesName.supportPage);

    }
    else {
      if (response.body.isNotEmpty) {
        final responseData = jsonDecode(response.body);
        if (!context.mounted) return ;
          ResponseMessageService.showErrorToast(context, responseData["errorDTOS"][0]["errorMessage"],);
      }
    }
  }
}