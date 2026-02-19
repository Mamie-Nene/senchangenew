import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field.dart';
import '../../widgets/main_button.dart';
import '../../widgets/select_field.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/methods/response_messages.dart';

class AddMobileMoneyAccount extends StatefulWidget {
  const AddMobileMoneyAccount({super.key});

  @override
  State<AddMobileMoneyAccount> createState() => _AddMobileMoneyAccountState();
}

class _AddMobileMoneyAccountState extends State<AddMobileMoneyAccount> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mobileMoneys = [
      {"label": "Wave", "iconUrl": AppImages.WAVE_ICON},
      {"label": "Orange Money", "iconUrl": AppImages.OM_ICON},
    ];
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text("Ajouter un compte mobile money"),
        backgroundColor: AppColors.bgColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: "Numéro de téléphone",
                      controller: phoneController,
                      type: TextInputType.phone,
                      logic: (value) {},
                    ),
                    SizedBox(height: AppDimensions.h15(context)),
                    SelectField(
                      optionList: mobileMoneys,
                      label: "Type de mobile money",
                      selectedValue: "Orange Money",
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  ResponseMessageService.showSuccessToast(
                    context,
                    "Compte ajouté avec succès",
                  );
                },
                child: MainButton(
                  backgroundColor: AppColors.orangeColor,
                  label: "Ajouter",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
