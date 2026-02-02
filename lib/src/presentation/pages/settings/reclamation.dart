
import 'package:flutter/material.dart';

import '/src/data/remote/reclamation_api.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class Reclamation extends StatefulWidget {
  const Reclamation({super.key});

  @override
  State<Reclamation> createState() => _ReclamationState();
}

class _ReclamationState extends State<Reclamation> {
  final _saveClaimKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();

  Map<String, String>? selectedType;
  Map<String, String>? _selectedValue;


  @override
  Widget build(BuildContext context) {
    final types = [
      {"label": "Problème sur une transaction", "valeur": "FUNCTIONAL_PROBLEM"},
      {"label": "Problème réception OTP", "valeur": "FAIL_OTP"},
      {"label": "Temps de traitement long", "valeur": "PROCESSING_TIME_OUT"},
      {"label": "Autres", "valeur": "OTHER"},
    ];

    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text("Réclamation"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _saveClaimKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // description
                     Text(
                      "Donnez les informations sur le problème rencontré",
                      style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                    ),
                    SizedBox(height: AppDimensions.h15(context)),
                    TextFormField(
                      controller: descriptionController,
                      minLines: 3,
                      maxLines: 6,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "La description est obligatoire";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:  BorderSide(color: AppColors.grisClair),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:  BorderSide(color: AppColors.orangeColor),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    SizedBox(height: AppDimensions.h15(context)),

                    // type de réclamation
                    SizedBox(height: AppDimensions.h15(context)),

                    Text("Choisissez le motif de votre réclamation", style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16))),

                    SizedBox(height: AppDimensions.h15(context)),

                    DropdownButtonFormField<String>(
                        value: _selectedValue?['valeur']?? types.first['valeur'],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:  BorderSide(color: AppColors.grisClair),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.orangeColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        hint: const Text('Sélectionnez un wallet'),
                        onChanged: ( String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              // find the selected map from the list
                              _selectedValue = types.firstWhere((type) => type['valeur'] == newValue);
                              selectedType = _selectedValue; // store the whole map if needed later
                            });
                            print(selectedType);
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champs est requis';
                          }
                          return null;
                        },
                        items: types.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value['valeur'], // unique key
                            child: Row(
                              children: [
                                if (value["iconUrl"] != null)
                                  Image.asset(
                                    value["iconUrl"]!,
                                    width: 24,
                                    height: 24,
                                  ),
                                const SizedBox(width: 5),
                                Text(value["label"] ?? "Inconnu"),
                              ],
                            ),
                          );
                        }).toList()


                    ),


                  ],
                ),
              ),
            ),
            CustomElevatedButton(
              action: () async{
                if (_saveClaimKey.currentState != null && _saveClaimKey.currentState!.validate()) {
                 await ReclamationApi().saveClaim(context,descriptionController.text,selectedType!).then
                   ((value) {
                   // réinitialiser le formulaire : vider les champs
                   _saveClaimKey.currentState!.reset();
                   descriptionController.clear();
                 });
                }
              },
              label: "Envoyer",
              color: AppColors.orangeColor,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}