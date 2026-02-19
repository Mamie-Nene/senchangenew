import 'package:flutter/material.dart';
import '/src/data/local/transaction_local_data.dart';
import '/src/domain/NewTransactionEntity.dart';
import '/src/presentation/widgets/app_utils.dart';


class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<NewTransactionEntity> transactions = TransactionLocalData().transactions;

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

        child:  AppUtilsWidget().buildListTransaction(transactions, false)
      ),
    );
  }
}

