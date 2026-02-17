import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppUtilsWidget{

  GestureDetector transactionTypeCard(BuildContext context,{
    required bool selected,
    required  IconData icon,
    required  String title,
    required  String subtitle,
    required  VoidCallback onTap,
    required bool active,
    required Color activeColor,
  }){
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: selected ? Colors.green : theme.dividerColor,
          ),
          color: selected ? Colors.green.withOpacity(0.1) : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: selected ? Colors.green : theme.dividerColor,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3D2A3A),
        ),
      ),
    );
  }

  Widget inputField({
    required  TextEditingController controller,
    required String hint,
    bool isPassword = false,bool isPasswordVisible = false,
    Widget? suffixIcon,
    required Icon iconData,
     String? Function(String?)? fieldLogic
  }) {

    return TextFormField(
      controller: controller,
      obscureText: isPasswordVisible,
      validator: fieldLogic??(value) {
        if (value == null || value.isEmpty) {
          return "Ce champs est requis";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      inputFormatters:[FilteringTextInputFormatter.deny(RegExp(r'\s'))] ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: iconData,
      //  prefixIcon: isPassword ? const Icon(Icons.lock_outline_rounded) : Icon(Icons.email_outlined),
        prefixIconColor: Color(0xFF3D2A3A),
        suffixIcon: suffixIcon,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5EEF3),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget circleUI(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }


}