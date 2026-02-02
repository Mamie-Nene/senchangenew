
import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? action;
  final bool? isEnabled;
  final Color textColor;

  const CustomElevatedButton({Key? key, required this.label, required this.color, required this.action, this.isEnabled, required this.textColor} ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action, //moi
     // onPressed: isEnabled != null && isEnabled == false ? null : action, // Callback du bouton

      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: isEnabled == true || isEnabled == null ? color : Colors.grey, // Couleur de fond
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordures arrondies
        ),
        padding: EdgeInsets.all(15), // Espacement interne
        minimumSize: Size(double.infinity, 0), // Largeur max, hauteur auto
        // elevation: 2, // Effet d'ombre léger
      ),
      child: Text(label,
        style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16), color: textColor), // Texte centré
        textAlign: TextAlign.center,
      ),
    );
  }
}
