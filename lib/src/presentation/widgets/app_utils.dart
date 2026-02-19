import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/domain/NewTransactionEntity.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

class AppUtilsWidget {

  GestureDetector transactionTypeCard(BuildContext context, {
    required bool selected,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool active,
    required Color activeColor,
  }) {
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

  Widget buildListTransaction(List<NewTransactionEntity> transactions,
      bool isForHomePage) {
    return ListView.separated(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        NewTransactionEntity transaction = transactions[index];
        final typeTransaction = getTransactionTypeTranslated(transaction.transaction_type);
        final statusTransaction = getTransactionStatusTranslated(transaction.status);

        final icon = getTransactionTypeIcon(transaction.transaction_type);
        final theme = Theme.of(context);

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutesName.detailTransactionPage,
                arguments: {"transaction": transaction});
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: isForHomePage ? Border.all(
                  color: Color(0xFF3D2A3A).withOpacity(0.2)) : null,
              color: isForHomePage
                  ? theme.cardColor
                  : Colors.white,
              // color:isForHomePage? AppColors.mainCardBgColor.withOpacity(0.2):Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 3,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.secondAppColor.withOpacity(0.2),
                              border: Border.all(
                                  color: AppColors.secondAppColor),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: icon
                        ),

                        Text(typeTransaction,
                          style: TextStyle(
                              color: AppColors.mainAppColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    StatusBadge(statusTransaction),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${transaction.from_amount.toString()} ${transaction
                        .from_currency}  →  ${transaction
                        .to_amount} ${transaction.to_currency}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    InfoChip(transaction.blockchain, Colors.blue,null),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(transaction.created_at,
                        style: TextStyle(
                          fontSize: 11,
                        )
                    ),
                    InfoChip("Frais: ${transaction.fee_amount}", Colors.orange,null),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ref: ${transaction.reference_code}",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.mainAppTextColor,
                        fontFamily: "monospace",
                      ),
                    ),

                    Icon(Icons.remove_red_eye, size: 18,
                        color: Colors.grey.shade500),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 10,);
      },
    );
  }

  Color getTransactionResultColor(String transactionStatus) {
    switch (transactionStatus) {
      case 'En Cours':
        return const Color(0xff1D4ED8);
      case 'Terminée':
        return const Color(0xff185C37);
      default:
        return const Color(0xffBC3618);
    }
  }

  Icon getTransactionTypeIcon(String transactionType) {
    switch (transactionType) {
      case 'buy':
        return Icon(Icons.north_east, color: Colors.green,);
      case 'sell':
        return Icon(Icons.south_west, color: Colors.red,);
      default:
        return Icon(Icons.swap_horiz, color: AppColors.secondAppColor,);
    }
  }

  String getTransactionTypeTranslated(String transactionType) {
    switch (transactionType) {
      case 'buy':
        return 'Achat';
      case 'sell':
        return 'Vente';
      default:
        return 'Échange';
    }
  }

  String getTransactionStatusTranslated(String transactionType) {
    switch (transactionType) {
      case 'completed':
        return 'Terminée';
      case 'failed':
        return 'Échouée';
      default:
        return 'En Cours';
    }
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
    required TextEditingController controller,
    required String hint,
    bool isPassword = false, bool isPasswordVisible = false,
    Widget? suffixIcon,
    required Icon iconData,
    String? Function(String?)? fieldLogic
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordVisible,
      validator: fieldLogic ?? (value) {
        if (value == null || value.isEmpty) {
          return "Ce champs est requis";
        }
        return null;
      },
      keyboardType: TextInputType.text,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        prefixIcon: iconData,
        //  prefixIcon: isPassword ? const Icon(Icons.lock_outline_rounded) : Icon(Icons.email_outlined),
        prefixIconColor: Color(0xFF3D2A3A),
        suffixIcon: suffixIcon,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5EEF3),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 14),
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


  StatusBadge(String text) {
    Color color;

    switch (text) {
      case "Échouée":
        color = Colors.red;
        break;
      case "En Cours":
        color = Colors.grey;
        break;
      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InfoChip(String text, Color color,IconData? icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 3),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  paymentMethodCard  (BuildContext context,{
    required String label,
    required String imageUrl,
    required bool selected,
    required VoidCallback onTap
  }){
    //,Theme.of(context).primaryColor
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ?Theme.of(context).primaryColor.withOpacity(0.1):Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: selected ? Color(0xFFF6B300) : Color(0xFF3D2A3A),
          ),
        ),
        child: Column(
          children: [
            Image.network(imageUrl, height: 40),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}