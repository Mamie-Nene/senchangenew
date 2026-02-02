import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class SelectField extends StatefulWidget {
  final String label;
  final List<dynamic> optionList;
  final String? iconUrl;
  dynamic selectedValue;
  final ValueChanged<String?>? onChanged; // Ajout du callback
  final FormFieldValidator<String>? validator;
  final String? setAsValue;
  SelectField({
    super.key,
    required this.optionList,
    this.selectedValue,
    this.iconUrl,
    required this.label,
    this.onChanged,
    this.validator,
    this.setAsValue,
  });

  @override
  State<SelectField> createState() => _SelectFieldState();
}

class _SelectFieldState extends State<SelectField> {
  String? _selectedValue; // Stocke localement la valeur sélectionnée

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue; // Initialise avec la valeur passée
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text(widget.label, style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,16))),
        if (widget.label.isNotEmpty) SizedBox(height: AppDimensions.h15(context)),
        DropdownButtonFormField<String>(
          value: _selectedValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: Colors.black,
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
            hintStyle:  TextStyle(color: AppColors.grisClair),
          ),
          hint: const Text(''),
          onChanged: (String? newValue) {
            setState(() {
              _selectedValue = newValue!;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue); // Notifie le parent
            }
          },
          // validator: (String? value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Veuillez selectionner un element';
          //   }
          //   return null;
          // },
          validator: widget.validator,
          items:
              widget.optionList.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value:
                      widget.setAsValue != null && widget.setAsValue!.isNotEmpty
                          ? widget.setAsValue!
                          : value["label"],
                  child: Row(
                    children: [
                      if (value["iconUrl"] != null)
                        Image.asset(value["iconUrl"]!, width: 24, height: 24),
                      if (value["iconUrl"] != null) SizedBox(width: 5),
                      Text(value["label"]),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
