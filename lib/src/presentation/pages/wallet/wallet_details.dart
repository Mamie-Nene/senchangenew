
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '/src/presentation/widgets/app_app_bars.dart';

import '/src/data/remote/wallet/wallet_api.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';
import '/src/presentation/widgets/select_field.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class WalletsDetailsPage extends StatefulWidget {

  final String nameWallet;
  final String address;
  final String blockChainType;
  final String id;
  const WalletsDetailsPage({Key? key, required this.nameWallet, required this.address, required this.blockChainType, required this.id}) : super(key: key);

  @override
  State<WalletsDetailsPage> createState() => _WalletsDetailsPageState();
}

class _WalletsDetailsPageState extends State<WalletsDetailsPage> {
  TextEditingController nomController = TextEditingController();
  TextEditingController adresseController = TextEditingController();

  final optionList = [
    {"label": "BTC"},
    {"label": "BSC"},
    {"label": "TRC20"},
    {"label": "SOL"},
  ];
  String selectedCurrency = "";

  final _detailWalletKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      nomController.setText(widget.nameWallet);
      adresseController.setText(widget.address);
      selectedCurrency = widget.blockChainType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppAppBars(
        title: "Détails portefeuille",
        action: () {Navigator.of(context).pop();},
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _detailWalletKey,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: "Nom",
                      controller: nomController,
                      logic: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le nom du portefeuille est requis";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.h15(context)),
                    CustomTextFormField(
                      label: "Adresse",

                      controller: adresseController,
                      logic: (value) {
                        if (value == null || value.isEmpty) {
                          return "L'adresse du portefeuille est requis";
                        }
                        /* if (selectedCurrency == "BSC" && value.length > 30) {
                           return "L'adresse du wallet ne doit pas dépasser 30 caractères";
                         }
                         if (selectedCurrency == "BTC" &&
                             (value.length < 25 || value.length > 36)) {
                           return "L'adresse du wallet doit etre comprise entre 26 et 26 caractères";
                         }
                         if (selectedCurrency == "TRC20" && value.length > 21) {
                           return "L'adresse du wallet ne doit pas dépasser 21 caractères";
                         }
                         if (selectedCurrency == "SOL" &&
                             (value.length < 32 || value.length > 44)) {
                           return "L'adresse du wallet doit etre comprise entre 32 et 44 caractères";
                         }*/
                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.h15(context)),
                    SelectField(
                      optionList: optionList,
                      selectedValue: selectedCurrency,
                      label: "Type de blockchain",
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedCurrency = selectedItem!;
                        });
                        print(selectedCurrency);
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Le type de portefeuille est requis';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              CustomElevatedButton(
                label: "Modifier",
                color: AppColors.orangeColor,
                textColor: Colors.black,
                action: () async {
                  if (selectedCurrency != "" && _detailWalletKey.currentState != null && _detailWalletKey.currentState!.validate()) {
                   await  WalletApi().updateWallet(
                      nomController.text,
                      adresseController.text,
                      selectedCurrency,
                      widget.id,
                      context
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
