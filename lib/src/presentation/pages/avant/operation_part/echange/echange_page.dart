
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '/src/data/local/transaction_local_data.dart';
import '/src/data/remote/transaction/operation_api.dart';

import '/src/presentation/widgets/app_app_bars.dart';
import '/src/presentation/widgets/transaction_detail_widgets.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/phone_field.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';


class EchangeScreen extends StatefulWidget {
  const EchangeScreen({super.key});

  @override
  State<EchangeScreen> createState() => _EchangeScreenState();
}

class _EchangeScreenState extends State<EchangeScreen> {
  final _exchangeCryptoFormKey = GlobalKey<FormState>();

  String selectedFromCurrency = "Dollar";
  String selectedToCurrency = "FCFA";

  TextEditingController userDeviseController = TextEditingController();
  TextEditingController toDeviseController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List fromCurrencies = TransactionLocalData().fromCurrencies;
  List toCurrencies  = TransactionLocalData().toCurrencies;

  // ----------------------- Function To Delete Devise Choisi des Devises Destinatires -----------------------------

  setToCurrencies(String currencyLabel) {
    if (selectedFromCurrency == "Dollar" || selectedFromCurrency == "Euro") {
      if (selectedToCurrency == "Dollar" || selectedToCurrency == "Euro") {
        setState(() {
          selectedToCurrency = "FCFA";
        });
      }
      setState(() {
        toCurrencies = [
          {"label": "FCFA", "iconUrl": AppImages.SN_FLAG_IMAGES},
        ];
      });
    } else {
      if (selectedToCurrency == "FCFA") {
        setState(() {
          selectedToCurrency = "Dollar";
        });
      }
      setState(() {
        toCurrencies = [
          {"label": "Dollar", "iconUrl": AppImages.US_FLAG_IMAGES},
          {"label": "Euro", "iconUrl":AppImages.UE_FLAG_IMAGES},
        ];
      });
    }
  }

  echangeBottomSheet(BuildContext context, TextEditingController userDeviseController, TextEditingController toDeviseController, String phoneController, String selectedFromCurrency, String selectedToCurrency ){
    return  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Vous échangez",
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.h10(context)),
                Text(
                  "${userDeviseController.text} $selectedFromCurrency",
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,20),
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.h20(context)),
                TransactionDetailsWidgets().rowForTransactionOperationDetails("Vous allez recevoir", "${toDeviseController.text} $selectedToCurrency",context),

                SizedBox(height: AppDimensions.h15(context)),
                TransactionDetailsWidgets().rowForTransactionOperationDetails("Numéro à joindre", phoneController,context),

                SizedBox(height: AppDimensions.h30(context)),

                CustomElevatedButton(
                  label: "Confirmer maintenant",
                  color: AppColors.orangeColor,
                  textColor: Colors.black,
                  action: () async {
                    await OperationApi().saveExchangeCrypto(context,
                      selectedFromCurrency,
                      selectedToCurrency,
                        toDeviseController.text,
                        userDeviseController.text,
                        phoneController
                    ).then((value) {
                      // réinitialiser le formulaire : vider les champs
                      _exchangeCryptoFormKey.currentState!.reset();
                      userDeviseController.clear();
                      toDeviseController.clear();
                    });
                  },
                ),
                SizedBox(height: AppDimensions.h10(context)),
              ],
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppAppBars(title: "Echange de devises",action:() {Navigator.of(context).pushNamed(AppRoutesName.accueilPage);} ,),

      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _exchangeCryptoFormKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // start: from
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vous convertissez",
                            style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                          ),
                          SizedBox(height: AppDimensions.h10(context)),

                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: userDeviseController,
                                  keyboardType: TextInputType.number,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Veuillez saisir le montant à convertir";
                                    }
                                    if (selectedFromCurrency == "FCFA" && int.parse(value.replaceAll(RegExp(r'\s+'), '',),) <
                                            (50000)) {
                                      return "Le montant ne doit pas être inférieur à 50.000 FCFA";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) async {
                                    if (value.isNotEmpty) {
                                    await  OperationApi().getAmountForExchange(
                                        double.parse(value),
                                        selectedFromCurrency,
                                        selectedToCurrency,
                                      ).then((valueGetted) {
                                        if(valueGetted!=null) {
                                          toDeviseController.setText(valueGetted);
                                        }
                                      });
                                    } else {
                                      toDeviseController.setText("");
                                    }
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorMaxLines: 3,
                                    prefixIconColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:  BorderSide(
                                       color: AppColors.grisClair
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                        color: AppColors.orangeColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    suffixIcon: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: AppColors.textGrisColor,
                                          ),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10,),
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        value: selectedFromCurrency,
                                        icon: Icon(Icons.arrow_drop_down),
                                        underline: SizedBox(),
                                        onChanged: (String? newValue) {
                                          if (newValue != selectedFromCurrency) {
                                            userDeviseController.setText("");
                                            toDeviseController.setText("");
                                          }
                                          setState(() {
                                            selectedFromCurrency = newValue!;
                                          });

                                          setToCurrencies(newValue!);
                                          // reinitailisation des champs
                                        },
                                        items: fromCurrencies.map<DropdownMenuItem<String>>((dynamic value) {
                                          return DropdownMenuItem<String>(
                                            value: value["label"],
                                            child: Row(
                                              children: [
                                                if (value["iconUrl"] != null)
                                                  Image.asset(
                                                    value["iconUrl"]!,
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                if (value["iconUrl"] != null)
                                                  SizedBox(width: 5),
                                                Text(value["label"]),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    hintStyle:  TextStyle(
                                     color: AppColors.grisClair
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // end : from
                      SizedBox(height: AppDimensions.h15(context)),

                      // start: to
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Vous allez recevoir",
                            style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
                          ),
                          SizedBox(height: AppDimensions.h10(context)),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: toDeviseController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    errorMaxLines: 3,
                                    prefixIconColor: Colors.black,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:  BorderSide(
                                       color: AppColors.grisClair
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                        color: AppColors.orangeColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    hintText: "",
                                    suffixIcon: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(
                                            color: AppColors.textGrisColor,
                                          ),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10,),
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        value: selectedToCurrency,
                                        icon: Icon(Icons.arrow_drop_down),
                                        underline: SizedBox(),
                                        onChanged: (String? newValue) {
                                          // reinitailisation des champs
                                          if (newValue != selectedToCurrency) {
                                            userDeviseController.setText("");
                                            toDeviseController.setText("");
                                          }

                                          setState(() {
                                            selectedToCurrency = newValue!;
                                          });
                                        },
                                        items: toCurrencies.map<DropdownMenuItem<String>>((dynamic value) {
                                          return DropdownMenuItem<String>(
                                            value: value["label"],
                                            child: Row(
                                              children: [
                                                if (value["iconUrl"] != null)
                                                  Image.asset(
                                                    value["iconUrl"]!,
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                if (value["iconUrl"] != null)
                                                  SizedBox(width: 5),
                                                Text(value["label"]),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                     color: AppColors.grisClair
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // end : to
                      SizedBox(height: AppDimensions.h15(context)),

                      // if (selectedFromCurrency == "FCFA")
                      PhoneNumberField(
                        label: "Saisissez votre numéro",
                        placeholder: "",
                        controller: phoneController,
                      ),
                          /* CheckboxListTile(
                             controlAffinity:
                                 ListTileControlAffinity
                                     .leading, // Place la case à cocher avant le texte
                             title: const Text(
                               "Utiliser mon numéro de téléphone",
                             ),
                             value: isUseMyNumberChecked,
                             activeColor: AppColors.orangeColor,
                             contentPadding: EdgeInsets.all(0),
                             onChanged: (bool? value) {
                               setState(() {
                                 isUseMyNumberChecked = value!;
                               });
                             },
                           ),*/
                    ],
                  ),
                ),

                // if (selectedFromCurrency == "FCFA")
                CustomElevatedButton(
                  label: "Suivant",
                  color: AppColors.orangeColor,
                  textColor: Colors.black,
                  action: () {
                    if (_exchangeCryptoFormKey.currentState != null && _exchangeCryptoFormKey.currentState!.validate()) {
                     echangeBottomSheet(
                         context,
                         userDeviseController,
                         toDeviseController,
                         phoneController.text,
                         selectedFromCurrency,
                         selectedToCurrency);
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