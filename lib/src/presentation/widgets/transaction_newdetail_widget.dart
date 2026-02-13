
import 'package:flutter/material.dart';
import '/src/presentation/pages/home_pages/accueil.dart';

class StatusBadge extends StatelessWidget {
  final String text;

  const StatusBadge(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    Color color;

    switch (text.toLowerCase()) {
      case "échouée":
        color = Colors.red;
        break;
      case "annulée":
        color = Colors.grey;
        break;
      default:
        color = Colors.blue;
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
         // color: color.shade300,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;

  const InfoChip(this.text, this.color, {this.icon, super.key});

  @override
  Widget build(BuildContext context) {
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
}

class TransactionCard extends StatelessWidget {
  final TransactionItem item;
  final VoidCallback? onTap;

  const TransactionCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final iconColor = item.isBuy ? Colors.green : Colors.red;
    final icon = item.isBuy ? Icons.arrow_downward : Icons.arrow_upward;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade800),
          color: Colors.grey.shade900.withOpacity(.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// LEFT
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ICON
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade800,
                    ),
                    child: Icon(icon, size: 18, color: iconColor),
                  ),
                  const SizedBox(width: 14),

                  /// TEXTS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE + STATUS
                        Row(
                          children: [
                            Text(
                              item.type,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 8),
                            StatusBadge(item.status),
                          ],
                        ),

                        const SizedBox(height: 4),

                        /// AMOUNT
                        Text(
                          item.amount,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400),
                        ),

                        const SizedBox(height: 4),

                        /// CHIPS ROW
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            Text(item.date,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade500)),
                            InfoChip(item.network, Colors.blue),
                            InfoChip("Frais: ${item.fee}", Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// RIGHT
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.reference,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                        fontFamily: "monospace",
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "via ${item.provider}",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Icon(Icons.remove_red_eye,
                    size: 18, color: Colors.grey.shade500),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
