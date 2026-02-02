import 'package:flutter/material.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

class MainButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  const MainButton({
    super.key,
    required this.backgroundColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),

      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          label,
          style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
