import 'package:flutter/material.dart';
import '/src/presentation/pages/operation_part/detailTransaction_new.dart';
import '/src/domain/models/TransactionModel.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EEF3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Transactions",
          style: TextStyle(
            color: Color(0xFF3D2A3A),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF3D2A3A)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _TransactionCard(
              type: "ACHAT",
              amount: "190.0 USDT",
              date: "Il y a 3 jours",
              status: "rejetée",
              statusColor: Colors.red,
            ),
            _TransactionCard(
              type: "ACHAT",
              amount: "100.0 USDT",
              date: "Il y a 4 jours",
              status: "acceptée",
              statusColor: Colors.green,
            ),
            _TransactionCard(
              type: "VENTE",
              amount: "500.0 USDT",
              date: "Il y a 5 jours",
              status: "acceptée",
              statusColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final String type;
  final String amount;
  final String date;
  final String status;
  final Color statusColor;

  const _TransactionCard({
    required this.type,
    required this.amount,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {// currency: "XOF",date: DateTime.parse(date)
  //  TransactionModel transactionModel = TransactionModel(id:"1", type: type, amount: amount, status: status, date: date, paymentMethod: "Wave");
    Transaction transaction = Transaction(reference: "12344", amountXof: 100.0, amountUsdt: 1000.0, paymentMethod: "Wave", network: "BEP20", walletAddress: "0X1222", txHash: "0X1222", createdAt: DateTime(2025, 1, 1), completedAt: DateTime(2025, 1, 1), status:TransactionStatus.completed);

    return InkWell(
      onTap: (){Navigator.of(context).pushNamed(
          AppRoutesName.detailTransactionPage,
          arguments: {
            "transaction":transaction
           // "transaction":transactionModel
          });},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFF6B300),
              child: const Icon(Icons.swap_horiz, color: Colors.yellow),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3D2A3A),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
