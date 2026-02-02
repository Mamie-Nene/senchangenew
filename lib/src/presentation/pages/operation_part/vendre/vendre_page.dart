
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:senchange/src/methods/response_messages.dart';

import '/src/data/local/transaction_steps.dart';
import '/src/data/remote/transaction/operation_api.dart';
import '/src/methods/storage_management.dart';
import '/src/methods/transform_format_methods.dart';

import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';
import '/src/presentation/widgets/selected_drop.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

import '/src/presentation/widgets/app_app_bars.dart';
import '/src/presentation/widgets/transaction_detail_widgets.dart';

class VendreScreen extends StatefulWidget {
  const VendreScreen({super.key});

  @override
  State<VendreScreen> createState() => _VendreScreenState();
}

class _VendreScreenState extends State<VendreScreen> {

  final _vendreFormKey = GlobalKey<FormState>();
  String? userPhone;
  TextEditingController montantUsdtController = TextEditingController();
  TextEditingController montantToPayController = TextEditingController();
  TextEditingController walletCrediteController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userWalletController = TextEditingController();
  TextEditingController defaultPhoneController = TextEditingController();
  bool useAnotherNumber = false;
  dynamic wallets;
  dynamic selectedWallet;
  final mobileMoneys =TransactionLocalData().mobileMoneys;
  dynamic selectedMobileMoney;

  // fonction pour recuperer les wallets de l'utilisateur
  getWallets(BuildContext context) async {
   /* await WalletApi().getWalletsWithData(context).then((value) {
      setState(() {
        wallets = value;
      });
    });*/
    await OperationApi().getWalletsForDropdownList(context).then(
            (value) {
          setState(() {
            wallets = value;
          });
        }
    );

  }

  // fonction pour recupérer le numero de wallet de senchange suivant le type de blockchain
  getSenchangeWallet(String typeBlockchain,BuildContext context) async {
    await OperationApi().getSenchangeWallet(typeBlockchain,context).then(
            (value) {
              if(value!=null){
                walletCrediteController.setText(value);
              }
        }
    );

  }

  // fonction pour recuperer le montant en fcfa
  getAmountToPay(int amount,BuildContext context) async{
    await OperationApi().getAmountToPayForOperation( context, amount, "VENTE").then(
            (value) {
              if(value!=null){
               // obtention du montant à payer
                TransformationFormatMethods.formatCurrency((value['totalAmount']).toString(), montantToPayController,);
                // montantToPayController.setText((responseData['results']).toString());
             }
          }
    );
  }

  //fonction pour récuperer le numero detelephone du user dans le storage
  void loadUserPhone() async {
    String? phone = await StorageManagement.getStorage("telephone");
    print(phone);
    setState(() {
      userPhone = phone;
    });
    if (userPhone != null) {
      defaultPhoneController.setText(userPhone!);
    }
  }



  @override
  void initState() {

    super.initState();
    // recuperer le numero de telephone du user
    loadUserPhone();
    getWallets(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.bgColor,

      appBar: AppAppBars(title: "Vente",action:() {Navigator.of(context).pushNamed(AppRoutesName.accueilPage);} ,),

      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _vendreFormKey,
            child: Column(
              children: [
                // formulaire d'achat
                Expanded(
                  child: ListView(
                    children: [
                      // montant en usdt
                      CustomTextFormField(
                        label: "Montant (en USDT)",
                        controller: montantUsdtController,
                        isDigitOnly: true,
                        logic: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez renseigner le montant que vous souhaitez vendre";
                          }
                          if (int.parse(value.replaceAll(RegExp(r'\s+'), '')) < 10) {
                            return "Le montant minimum requis est de 10 USDT.";
                          }
                          return null;
                        },
                        type: TextInputType.number,
                        onChanged: (value) {
                          // calcul des montant
                          TransformationFormatMethods.formatCurrency(value, montantUsdtController,);

                          if (value.isNotEmpty && RegExp(r'^\d+$').hasMatch(value)) {
                            getAmountToPay(int.parse(value),context);
                          } else {
                            montantToPayController.setText("");
                          }
                        },
                      ),
                      SizedBox(height: AppDimensions.h15(context)),
                      // montant à payer
                      DisabledField(
                        label: "Vous allez recevoir (en FCFA)",
                        placeholder: "",
                        controller: montantToPayController,
                        logic: (value) {},
                        type: TextInputType.number,
                      ),

                      SizedBox(height: AppDimensions.h15(context)),
                      // wallets de l'utilisateur
                      SelectedDropForWallet(
                        optionList: wallets,
                        label: "Votre portefeuille",
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedWallet = value;
                            });
                            getSenchangeWallet(value['blockChainType']!,context);
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Veuillez selectionner un portefeuille";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppDimensions.h15(context)),
                      // wallet
                      DisabledField(
                        label: "Portefeuille à créditer",
                        placeholder: "",
                        controller: walletCrediteController,
                        setSuffixIcon: true,
                        action: () {
                          Clipboard.setData(ClipboardData(text: walletCrediteController.text),);
                          ScaffoldMessenger.of(context).showSnackBar(
                            ResponseMessageService().getSnackBarForSuccessReturn(context,"Numéro de portefeuille copié !")
                          );
                        },
                        logic: (value) {},
                      ),

                      SizedBox(height: AppDimensions.h15(context)),
                      // mobile money
                      SelectedDrop(
                        optionList:mobileMoneys,
                        label: "Type de compte mobile money",
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedMobileMoney = value;
                              print(selectedMobileMoney);
                            });
                          }
                        },
                      ),
                      SizedBox(height: AppDimensions.h15(context)),
                      // le numero de téléphone du client
                      DisabledField(
                        label: "Votre numéro de téléphone",
                        placeholder: "",
                        controller: defaultPhoneController,
                        logic: (value) {
                          return null;
                        },
                      ),
                      // utiliser un autre numero
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading, // Place la case à cocher avant le texte
                        title: const Text('Utiliser un autre numéro'),
                        value: useAnotherNumber,
                        activeColor: AppColors.orangeColor,
                        contentPadding: EdgeInsets.all(0),
                        onChanged: (bool? value) {
                          setState(() {
                            useAnotherNumber = value!;
                          });
                        },
                      ),

                      if (useAnotherNumber)
                        CustomTextFormField(
                          label: "Numéro de téléphone",
                          controller: phoneController,
                          logic: (value) {
                            if (useAnotherNumber) {
                              if (value == null || value.isEmpty) {
                                return "Le numéro de téléphone est requis";
                              }
                              return null;
                            }
                            return null;
                            },
                        ),

                      SizedBox(height: AppDimensions.h15(context)),
                      CustomElevatedButton(
                        label: "Suivant",
                        color: AppColors.orangeColor,
                        textColor: Colors.black,
                        action: () {
                          if (_vendreFormKey.currentState != null && _vendreFormKey.currentState!.validate()) {
                            vendreBottomSheet(context);
                          }
                        },
                      ),

                      SizedBox(height: AppDimensions.h15(context)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  vendreBottomSheet(BuildContext context){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight:
        MediaQuery.of(context).size.height *
            0.5, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return  Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Vous vendez",
                style: TextStyle(
                  fontSize: AppDimensions().responsiveFont(context,18),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppDimensions.h10(context)),
              Text(
                "${montantUsdtController.text} USDT",
                style: TextStyle(
                  fontSize: AppDimensions().responsiveFont(context,20),
                  color: AppColors.orangeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppDimensions.h20(context)),
              TransactionDetailsWidgets().rowForTransactionOperationDetails("Vous allez recevoir","${montantToPayController.text} FCFA",context),

              SizedBox(height: AppDimensions.h15(context)),
              TransactionDetailsWidgets().rowForTransactionOperationDetails("Sur le compte","${selectedMobileMoney['label']}, ${useAnotherNumber ? phoneController.text : defaultPhoneController.text}",context),

              SizedBox(height: AppDimensions.h20(context)),
              TransactionDetailsWidgets().rowForTransactionOperationDetails("Votre portefeuille",TransformationFormatMethods.truncateWithEllipsis(10, selectedWallet["address"],),context),

              SizedBox(height: AppDimensions.h15(context)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Portefeuille",
                    style: TextStyle(
                      fontSize: AppDimensions().responsiveFont(context,16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(TransformationFormatMethods.truncateWithEllipsis(10, walletCrediteController.text,),
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: walletCrediteController.text,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            ResponseMessageService().getSnackBarForSuccessReturn(context,"Numéro de wallet copié !")
                          );
                        },
                        icon: Icon(Icons.copy),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.h30(context)),

              CustomElevatedButton(
                label: "Vendre maintenant",
                color: AppColors.orangeColor,
                textColor: Colors.black,
                action: () async{
                 await OperationApi().sellCrypto(
                     context,
                     montantUsdtController.text,
                     montantToPayController.text,
                     selectedWallet,
                     walletCrediteController.text,
                     useAnotherNumber ? phoneController.text : defaultPhoneController.text,
                     selectedMobileMoney
                 );
                },
              ),
              SizedBox(height: AppDimensions.h10(context)),
            ],
          ),
        );
      },
    );
  }
}