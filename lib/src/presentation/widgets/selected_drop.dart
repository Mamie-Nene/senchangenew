import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class SelectedDropForWallet extends StatefulWidget {
  final String label;
  final List<Map<String, String>>? optionList;
  final ValueChanged<Map<String, String>?>?onChanged; // Renvoie l'objet complet
  final FormFieldValidator<String>? validator;

  const SelectedDropForWallet({
    super.key,
    required this.optionList,
    required this.label,
    this.onChanged,
    this.validator,
  });

  @override
  State<SelectedDropForWallet> createState() => _SelectedDropForWalletState();
}

class _SelectedDropForWalletState extends State<SelectedDropForWallet> {
  Map<String, String>? _selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)...[
          Text(widget.label, style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,16))),
          SizedBox(height: AppDimensions.h15(context)),
        ],

        DropdownButtonFormField<Map<String, String>>(
           value: _selectedValue,
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
          onChanged: (Map<String, String>? newValue) {
               print("new valeur $newValue");
               setState(() { _selectedValue = newValue; });
               if (widget.onChanged != null) {
                 widget.onChanged!(newValue); }
           },
          validator: (value) {
             if (value == null) {// if (value == null || value['label'] == null || value['label']!.isEmpty) {
               return 'Ce champs est requis';
             }
             return null;
          },
          items: widget.optionList != null ? // widget.optionList != null && widget.optionList!.isNotEmpty ?
          widget.optionList!.map((value) => DropdownMenuItem(value: value, child: Text(value["label"] ?? "Inconnu"))
          ).toList()
              :
          [
            const DropdownMenuItem(
            value: null,
            child: Text( 'Aucune option disponible',
              style: TextStyle(color: Colors.grey), ),
            ),
          ],
        ),
      ],
    );
  }
}

class SelectedDrop extends StatefulWidget {
  final String label;
  final List<Map<String, String>>? optionList;
  final ValueChanged<Map<String, String>?>?onChanged; // Renvoie l'objet complet
  final FormFieldValidator<String>? validator;

  SelectedDrop({
    super.key,
    required this.optionList,
    required this.label,
    this.onChanged,
    this.validator,
  });

  @override
  State<SelectedDrop> createState() => _SelectedDropState();
}

class _SelectedDropState extends State<SelectedDrop> {
  Map<String, String>? _selectedValue;
  String? _selectedOperator;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Column(
            children: [
              Text(widget.label, style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16))),
              SizedBox(height: AppDimensions.h15(context)),
            ],
          ),

        DropdownButtonFormField(
            value: _selectedOperator,
            // value: _selectedValue,
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
              print("new valeur $newValue");
              setState(() {
                // _selectedValue = newValue;
                _selectedOperator = newValue;

              });
              if (widget.onChanged != null) {
                final selectedItem = widget.optionList?.firstWhere(
                      (item) => item['operator'] == newValue,
                );
                //  widget.onChanged!(newValue);
                widget.onChanged!(selectedItem);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                // if (value == null || value['label'] == null || value['label']!.isEmpty) {
                return 'Ce champs est requis';
              }
              return null;
            },
            items:   widget.optionList?.map((value) {
              /*items:   widget.optionList != null && widget.optionList!.isNotEmpty ?
          widget.optionList!.map((value) => DropdownMenuItem(
                  value: value,
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
                )).toList()
                : [
            const DropdownMenuItem(
              value: null,
              child: Text(
                'Aucune option disponible',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],*/
              return DropdownMenuItem<String>(
                value: value["operator"], // unique key
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
    );
  }
}