import 'package:flutter/material.dart';

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
}