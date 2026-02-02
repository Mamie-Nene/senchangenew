import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:pinput/pinput.dart';
import 'package:senchange/src/domain/WalletEntity.dart';
import 'package:senchange/src/presentation/widgets/transaction_detail_widgets.dart';


import '../../../widgets/transaction_detail_widgets.dart';
import '/src/utils/consts/constants.dart';
import '/src/data/remote/transaction/operation_api.dart';
import '/src/services/utils.service.dart';

import '/src/utils/consts/routes/app_routes_name.dart';

import '/src/methods/transform_format_methods.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';
import '/src/presentation/widgets/selected_drop.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

import '../../../widgets/app_app_bars.dart';

class AcheterScreen extends StatefulWidget {
  const AcheterScreen({super.key});

  @override
  State<AcheterScreen> createState() => _AcheterScreenState();
}

class _AcheterScreenState extends State<AcheterScreen> {
  final _achatFormKey = GlobalKey<FormState>();
  TextEditingController montantUsdtController = TextEditingController();
  TextEditingController montantToPayController = TextEditingController();

  String? selectedWallet;
  String? montantHT;
  String? taxe;
  dynamic wallets;

  // fonction pour recuperer et afficher le montant à payer
  getAmountToPay(int amount,BuildContext context) async{
    await OperationApi().getAmountToPayForOperation( context, amount, "ACHAT").then(
            (value) {
              if(value!=null){
                // obtention du montant à payer
                TransformationFormatMethods.formatCurrency((value['totalAmount']).toString(), montantToPayController,);
                // montant hors taxe
                setState(() {
                  montantHT = TransformationFormatMethods.formatCurrencyAmount(value['amountHT'].toString(),);
                });
                // taxe
                setState(() {
                  taxe = TransformationFormatMethods.formatCurrencyAmount(value['feeTaxe'].toString(),);
                });
                // montantToPayController.setText((responseData['results']).toString());

              }
            }
     );
  }

  // fonction pour recuperer les wallets de l'utilisateur
  getWallets(BuildContext context) async {
    await OperationApi().getWalletsForDropdownList(context).then(
            (value) {
              setState(() {
                wallets = value;
              });
            }
    );
  }

  _openPaymentBottomSheet(BuildContext context,String montantUsdtController, String montantToPayController,String addressWallet, ) {
    // fermer le premimer modal
    Navigator.pop(context);
    String? selectedMethod;
    // reinitialisation de la selection ->
    // setState(() {selectedMethod = null;});

    return  showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 Text(
                    'Choisissez un moyen de paiement',
                    style: TextStyle(fontSize: AppDimensions().responsiveFont(context,18), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  RadioListTile<String>(
                    value: "wave",
                    groupValue: selectedMethod,
                    onChanged: (value) {
                      setModalState(() => selectedMethod = value);
                      setState(() => selectedMethod = value);

                    },
                    title: const Text('Wave'),
                    secondary: Image.asset(AppImages.WAVE_ICON, width: 40,),
                  ),
                  /* RadioListTile<String>(
                     value: "orange_money",
                     groupValue: _selectedMethod,
                     onChanged: (value) {
                       setModalState(() => _selectedMethod = value);
                       setState(() => _selectedMethod = value);
                     },
                     title: const Text('Orange Money'),
                     secondary: Image.asset(
                       'assets/images/icons/om.png',
                       width: 40,
                     ),
                   ),
                   SizedBox(height: AppDimensions.h20(context)),*/
                  CustomElevatedButton(
                    label: "Acheter maintenant",
                    color: AppColors.orangeColor,
                    textColor: Colors.black,
                    isEnabled: selectedMethod != null,
                    action: () async{
                      print("methode sélectionée $selectedMethod");
                     await OperationApi().buyCrypto(context,montantUsdtController, montantToPayController,addressWallet,selectedMethod!);
                    },
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }

  achatBottomSheet(BuildContext context, String montantUsdtController, String montantToPayController,String? addressWallet){
    return  showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {

        return  Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Vous achetez",
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.h10(context)),
                Text("$montantUsdtController USDT",
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,22),
                    color: AppColors.orangeFonce,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppDimensions.h20(context)),
                TransactionDetailsWidgets().rowForTransactionOperationDetails("Vous allez payer","$montantToPayController FCFA",context),

                if (montantHT != null) ...[
                  SizedBox(height: AppDimensions.h15(context)),
                  TransactionDetailsWidgets().rowForTransactionOperationDetails("Montant hors taxe","$montantHT FCFA",context),
                ],
                if (taxe != null) ...[
                  SizedBox(height: AppDimensions.h15(context)),
                  TransactionDetailsWidgets().rowForTransactionOperationDetails("Montant de la taxe","$taxe FCFA",context),
                ],
                SizedBox(height: AppDimensions.h15(context)),
                TransactionDetailsWidgets().rowForTransactionOperationDetails("Votre portefeuille",TransformationFormatMethods.truncateWithEllipsis(10, addressWallet!,),context),

                /* SizedBox(height: AppDimensions.h15(context)),
                 Row(
                   mainAxisAlignment:
                       MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "Votre moyen de paiement",
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Text(
                       selectedMobileMoney['label'],
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w400,
                       ),
                     ),
                   ],
                 ),
                 RadioListTile<String>(
                   value: "wave",
                   groupValue: _selectedMethod,
                   onChanged: (value) {
                     setState(() {
                       _selectedMethod = value;
                     });
                   },
                   title: const Text('Payer avec Wave'),
                   secondary: Image.asset(
                     'assets/images/icons/wave.png',
                     width: 40,
                   ),
                 ),
                 RadioListTile<String>(
                   value: "orange",
                   groupValue: _selectedMethod,
                   onChanged: (value) {
                     setState(() {
                       _selectedMethod = value;
                     });
                   },
                   title: const Text(
                     'Payer avec Orange Money',
                   ),
                   secondary: Image.asset(
                     'assets/images/icons/om.png',
                     width: 40,
                   ),
                 ),*/
                SizedBox(height: AppDimensions.h30(context)),
                CustomElevatedButton(
                  label: "Continuer",
                  color: AppColors.orangeColor,
                  textColor: Colors.black,
                  action: () {
                    _openPaymentBottomSheet(context,montantUsdtController,montantToPayController,addressWallet);
                    // processus d'achat
                    // buy();
                  },
                ),

              ],
            ),
          );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWallets(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,
      appBar: AppAppBars(title: "Achat",action:() {Navigator.of(context).pushNamed(AppRoutesName.accueilPage);} ,),

      body: SafeArea(
        top: false,
        child: Form(
          key: _achatFormKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // formulaire d'achat
                Expanded(
                  child: ListView(
                    children: [
                      // montant en usdt
                      CustomTextFormField(
                        label: "Montant (en USDT)",
                        type: TextInputType.number,
                        controller: montantUsdtController,
                        isDigitOnly: true,
                        onChanged: (value) {
                          // calcul des montant
                          TransformationFormatMethods.formatCurrency(value, montantUsdtController,);

                          if (value.isNotEmpty && RegExp(r'^\d+$').hasMatch(value)) {
                            getAmountToPay(int.parse(value),context);
                          }
                          else {
                            montantToPayController.setText("");
                          }
                        },
                        logic: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez saisir le montant en USDT que vous souhaitez acheter";
                          }
                          if (int.parse(value.replaceAll(RegExp(r'\s+'), '')) < 10) {
                            return "Le montant minimum requis est de 10 USDT.";
                          }
                          if (int.parse(value.replaceAll(RegExp(r'\s+'), '')) > 1500) {
                            return "Le montant ne doit pas dépasser 1 500 USDT";
                          }

                          return null;

                        },
                      ),

                      SizedBox(height: AppDimensions.h15(context)),
                      // montant à payer
                      DisabledField(
                        label: "Vous allez payer (en FCFA)",
                        placeholder: "",
                        controller: montantToPayController,
                        logic: (value) {},
                        type: TextInputType.number,
                      ),
                      SizedBox(height: AppDimensions.h15(context)),
                      // if (wallets != null)
                      SelectedDropForWallet(
                        optionList: wallets,
                        label: "Portefeuille",
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedWallet = value["address"];
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Veuillez selectionner un portefeuille";
                          }
                          return null;
                        },
                      ),
                      // msg warning
                      SizedBox(height: AppDimensions.h15(context)),

                      // infos des taxes
                      if (montantHT != null)
                        ListTile(
                          title: Text("Montant hors taxe"),
                          trailing: Text(montantHT!, style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),),
                          contentPadding: EdgeInsets.all(0),
                        ),

                      if (taxe != null)
                        ListTile(
                          title: Text("Montant de la taxe"),
                          trailing: Text(taxe!, style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16))),
                          contentPadding: EdgeInsets.all(0),
                        ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15,bottom: 20),
                        child: Divider(),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                             TextSpan(
                              text:AppText.BUY_CRYTO_SUPERIOR_TO_1500_TEXT,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: AppDimensions().responsiveFont(context,16),
                              ),
                            ),
                            TextSpan(
                              text: Constants.whatsapppSupportNumber,
                              style:  TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: AppDimensions().responsiveFont(context,16),
                              ),
                              recognizer:
                              TapGestureRecognizer()
                                ..onTap = () => UtilsService.startPhoneCall(Constants.whatsapppSupportNumber, context: context,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: CustomElevatedButton(
                    label: "Confirmer",
                    color: AppColors.orangeColor,
                    textColor: Colors.black,
                    action: () {
                      if (_achatFormKey.currentState != null && _achatFormKey.currentState!.validate()) {
                       achatBottomSheet(context,montantUsdtController.text,montantToPayController.text,selectedWallet);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}