import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';


class CustomTextFormField extends StatelessWidget {
  final String label;

  final TextEditingController controller;
  final String? subText;
  final Icon? icon;
  final String? Function(String?)? logic;
  final TextInputType? type;
  final bool? required;
  final bool? isDigitOnly;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.subText,
    this.icon,
    this.type,
    required this.logic,
    this.required,
    this.isDigitOnly,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
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
        if (label.isNotEmpty)
          SizedBox(height: AppDimensions.h15(context)),
        TextFormField(
          controller: controller,
          keyboardType: type,
          validator: logic,
          inputFormatters:
              isDigitOnly != null && isDigitOnly == true
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],

          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: Colors.black,
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

            /*  prefixIcon:
                  const Image(image: AssetImage("assets/images/senegal.png")), */
            prefixIcon: icon,
            hintStyle:  TextStyle(color: AppColors.grisClair),
          ),
        ),
      ],
    );
  }
}
class CustomTextFormFieldForMail extends StatelessWidget {
  final String label;

  final TextEditingController controller;
  final String? subText;
  final Icon? icon;
  final String? Function(String?)? logic;
  final TextInputType? type;
  final bool? required;
  final bool? isDigitOnly;
  final ValueChanged<String>? onChanged;

  const CustomTextFormFieldForMail({
    super.key,
    required this.label,
    required this.controller,
    this.subText,
    this.icon,
    this.type,
    required this.logic,
    this.required,
    this.isDigitOnly,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
            children: [
              if (required != null && required == true)
                const TextSpan(
                  text: '*', // Étoile rouge
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        if (label.isNotEmpty)
          SizedBox(height: AppDimensions.h15(context)),
        TextFormField(
          controller: controller,
          keyboardType: type,
          validator: logic,
          inputFormatters:
              isDigitOnly != null && isDigitOnly == true
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],

          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIconColor: Colors.black,
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

            /*  prefixIcon:
                  const Image(image: AssetImage("assets/images/senegal.png")), */
            prefixIcon: icon,
            hintStyle:  TextStyle(color: AppColors.grisClair),
          ),
        ),
      ],
    );
  }
}


class DisabledField extends StatelessWidget {

  final String label;
  final String placeholder;
  final TextEditingController controller;
  final String? subText;
  final Icon? icon;
  final String? Function(String?)? logic;
  final TextInputType? type;
  final bool setSuffixIcon;
  Function()? action;

  DisabledField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.subText,
    this.icon,
    this.type,
    required this.logic,
    this.setSuffixIcon = false,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label, style: const TextStyle(fontSize: 16)),
        if (label.isNotEmpty) SizedBox(height: AppDimensions.h15(context)),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: type,
                validator: logic,
                enabled: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF1F0F0),
                  prefixIconColor: Colors.black,
                  disabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:  BorderSide(color: AppColors.grisClair),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: AppColors.mainVioletColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // suffixIcon: setSuffixIcon ? IconButton(onPressed: action, icon: Icon(Icons.copy)) : null,
                  hintText: placeholder,

                  /*  prefixIcon:
                        const Image(image: AssetImage("assets/images/senegal.png")), */
                  prefixIcon: icon,
                  hintStyle:  TextStyle(color: AppColors.grisClair),
                ),
              ),
            ),
            if(setSuffixIcon) IconButton(onPressed: action, icon: Icon(Icons.copy))
          ],
        ),
      ],
    );
  }
}

class FieldDropdown extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final String? subText;
  final String? Function(String?)? logic;
  final TextInputType? type;
  dynamic selectedItem;
  final List<dynamic> items;
  final ValueChanged<String?>? onChanged; // Ajout du callback
  FieldDropdown({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.subText,
    this.type,
    required this.logic,
    this.selectedItem,
    required this.items,
    this.onChanged,
  });

  @override
  State<FieldDropdown> createState() => _FieldDropdownState();
}

class _FieldDropdownState extends State<FieldDropdown> {
  // final TextEditingController _controller = TextEditingController();
  // String selectedCurrency = "FCFA";
  // final List<String> currencies = ["FCFA", "USD", "EUR"];

  String? _selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text(widget.label, style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,16))),
        if (widget.label.isNotEmpty) SizedBox(height: AppDimensions.h15(context)),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  errorMaxLines: 3,
                  prefixIconColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:  BorderSide(color: AppColors.grisClair),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(color: AppColors.orangeColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: widget.placeholder,
                  suffixIcon: Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: AppColors.textGrisColor)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: _selectedItem,
                      hint: Text("En..."),
                      icon: Icon(Icons.arrow_drop_down),
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedItem = newValue!;
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(newValue);
                        }
                      },
                      items:
                      widget.items.map<DropdownMenuItem<String>>((
                          dynamic value,
                          ) {
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

                  /*  prefixIcon:
                      const Image(image: AssetImage("assets/images/senegal.png")), */
                  hintStyle:  TextStyle(color: AppColors.grisClair),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


class PasswordField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final String? Function(String?)? logic;
  final bool? required;
  const PasswordField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    required this.logic,
    this.required,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool hidetext = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: widget.label,
            style:  TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
            children: [
              if (widget.required != null && widget.required == true)
                TextSpan(
                  text: '*', // Étoile rouge
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        // Text(widget.label, style: const TextStyle(fontSize: 16)),
        if (widget.label.isNotEmpty) SizedBox(height: AppDimensions.h10(context)),

        TextFormField(
          obscureText: hidetext,
          controller: widget.controller,

          // keyboardType: TextInputType.phone,
          validator: widget.logic,
          decoration: InputDecoration(
            //F9F9F9
            /*  contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 0), */
            filled: true,
            fillColor: Colors.white,
            errorMaxLines: 3,
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
            hintText: widget.placeholder,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidetext = !hidetext;
                });
              },
              icon: Icon(
                  hidetext == false ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grisClair
              ),
            ),
            hintStyle: TextStyle(color: AppColors.grisClair),
          ),
        ),
      ],
    );
  }
}

