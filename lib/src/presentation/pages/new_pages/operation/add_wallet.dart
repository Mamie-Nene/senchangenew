
import 'package:flutter/material.dart';
import '/src/presentation/widgets/app_app_bars.dart';

import '/src/data/remote/wallet/wallet_api.dart';
import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/custom_text_form_field.dart';
import '/src/presentation/widgets/select_field.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class AddWallet extends StatefulWidget {
  const AddWallet({super.key});

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  final _addWalletformKey = GlobalKey<FormState>();
  String selectedCurrency = "";
  String selectedNetwork = 'TRC20';
  String stableCoin = 'USDT';
  TextEditingController nomController = TextEditingController();
  TextEditingController adresseController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final optionList = [
      {"label": "BTC"},
      {"label": "BSC"},
      {"label": "TRC20"},
      {"label": "SOL"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
     // backgroundColor: AppColors.bgColor,

    //  appBar: AppAppBars(title: "Ajouter portefeuille",action:() {Navigator.of(context).pop();} ,),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Ajout portefeuille",
          style: TextStyle(
            color: Color(0xFF3D2A3A),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF3D2A3A)),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _addWalletformKey,
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
                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.h15(context)),
                    SelectField(
                      optionList: optionList,
                      label: "Type de blockchain",
                      onChanged: (String? selectedItem) {
                        setState(() {
                          selectedCurrency = selectedItem!;
                        });
                        print(selectedCurrency);
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Le type de blockchain est requis';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                ),
              CustomElevatedButton(
                label: "Ajouter",
                color: AppColors.orangeColor,
                textColor: Colors.black,
                action: ()async {
                  if (selectedCurrency != "" && _addWalletformKey.currentState != null && _addWalletformKey.currentState!.validate()) {
                   await  WalletApi().saveWallet(
                      context,
                      nomController.text,
                      adresseController.text,
                      selectedCurrency,
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
