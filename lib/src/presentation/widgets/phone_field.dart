import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/constants.dart';



class PhoneNumberField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool? required;

  const PhoneNumberField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.required,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
            children: [
              if (required != null && required == true)
                 TextSpan(
                  text: '*', // Étoile rouge
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: AppDimensions().responsiveFont(context,16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: AppDimensions.h15(context)),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Le numéro de téléphone est obligatoire";
            }
            if (!Constants.phoneRegExp.hasMatch(value)) {
              return "Le numéro de téléphone est incorrect";
            }
            return null;
          },
          decoration: InputDecoration(
            //F9F9F9
            // contentPadding: const EdgeInsets.symmetric(
            //   vertical: 20,
            //   horizontal: 0,
            // ),
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: AppColors.grisClair,
            errorMaxLines: 3,
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
            hintText: placeholder,

            /*  prefixIcon:
                  const Image(image: AssetImage("assets/images/senegal.png")), */
            // prefixIcon: const Icon(Icons.phone),
            hintStyle:  TextStyle(color: AppColors.grisClair),
          ),
        ),
      ],
    );
  }
}
