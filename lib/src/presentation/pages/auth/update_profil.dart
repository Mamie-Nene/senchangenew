
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../widgets/app_app_bars.dart';
import '/src/data/remote/auth/auth_api.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';
import '/src/presentation/widgets/phone_field.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

import '/src/methods/storage_management.dart';


class UpdateProfil extends StatefulWidget {
  const UpdateProfil({super.key});

  @override
  State<UpdateProfil> createState() => _UpdateProfilState();
}

class _UpdateProfilState extends State<UpdateProfil> {
  final _updateProfilKey = GlobalKey<FormState>(); // Définition de la clé

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // fonction pour récuperer les infos de l'utilisateur
  getUserInfos() async {
    var prenom = await StorageManagement.getStorage("prenom");
    var nom = await StorageManagement.getStorage("nom");
    var telephone = await StorageManagement.getStorage("telephone");
    if (prenom != null && prenom.isNotEmpty) {
      prenomController.setText(prenom);
    }

    if (nom != null && nom.isNotEmpty) {
      nomController.setText(nom);
    }

    if (telephone != null && telephone.isNotEmpty) {
      phoneController.setText(telephone);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppAppBars(title: "Modifier mon profil",action:() {Navigator.of(context).pushNamed(AppRoutesName.parametrePage);} ,),


      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _updateProfilKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: AppDimensions.h20(context)),
                      CustomTextFormField(
                        label: "Prénom",
                        controller: prenomController,
                        logic: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le prénom est requis";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: AppDimensions.h20(context)),

                      CustomTextFormField(
                        label: "Nom",
                        controller: nomController,
                        logic: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le nom est requis";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimensions.h20(context)),
                      PhoneNumberField(
                        label: "Téléphone",
                        placeholder: "",
                        controller: phoneController,
                      ),
                    ],
                  ),
                ),

                CustomElevatedButton(
                  label: "Enregistrer",
                  color: AppColors.orangeColor,
                  textColor: Colors.black,
                  action: () async{
                    print("update user");
                    if (_updateProfilKey.currentState != null && _updateProfilKey.currentState!.validate()) {
                     await  AuthApi().updateUser(context, prenomController.text, nomController.text, phoneController.text,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
