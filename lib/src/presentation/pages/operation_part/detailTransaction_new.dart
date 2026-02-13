import 'package:flutter/material.dart';
import '/src/domain/models/TransactionModel.dart';

enum TransactionStatus { created, pending, processing, completed }

class Transaction {
  final String reference;
  final double amountXof;
  final double amountUsdt;
  final String paymentMethod;
  final String network;
  final String walletAddress;
  final String txHash;
  final DateTime createdAt;
  final DateTime completedAt;
  final TransactionStatus status;

  Transaction({
    required this.reference,
    required this.amountXof,
    required this.amountUsdt,
    required this.paymentMethod,
    required this.network,
    required this.walletAddress,
    required this.txHash,
    required this.createdAt,
    required this.completedAt,
    required this.status,
  });
}
class TransactionDetailScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de la transaction"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _StatusBadge(transaction.status),
            const SizedBox(height: 16),
            _AmountCard(transaction),
            const SizedBox(height: 16),
            _InfoGrid(transaction),
            const SizedBox(height: 16),
            _StatusTimeline(transaction),
            const SizedBox(height: 16),
            _WalletSection(transaction),
            const SizedBox(height: 16),
            _BlockchainSection(transaction),
          ],
        ),
      ),
    );
  }
}
class _StatusBadge extends StatelessWidget {
  final TransactionStatus status;

  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == TransactionStatus.completed;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green.withOpacity(.15) : Colors.orange.withOpacity(.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.access_time,
            size: 18,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 8),
          Text(
            isCompleted ? "Complétée" : "En cours",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isCompleted ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
class _AmountCard extends StatelessWidget {
  final Transaction t;

  const _AmountCard(this.t);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF6B300).withOpacity(.08),
            //Theme.of(context).primaryColor.withOpacity(.08),
            Colors.transparent,
          ],
        ),
        border: Border.all(color: const Color(0xFFF6B300).withOpacity(.15)),
      //  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.15)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  t.amountXof.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:  Color(0xFF3D2A3A),fontWeight: FontWeight.bold),
                ),
             Text("XOF",style: TextStyle(color: Color(0xFF3D2A3A),)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward),
          Expanded(
            child: Column(
              children: [
                Text(
                  t.amountUsdt.toStringAsFixed(2),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Color(0xFFF6B300)),
                ),
                const Text("USDT"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _InfoGrid extends StatelessWidget {
  final Transaction t;

  const _InfoGrid(this.t);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.6,
      ),
      children: [
        _InfoTile("Référence", t.reference),
        _InfoTile("Méthode", t.paymentMethod),
        _InfoTile("Réseau", t.network),
        _InfoTile("Date", t.createdAt.toString()),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
class _StatusTimeline extends StatelessWidget {
  final Transaction t;

  const _StatusTimeline(this.t);

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Créée",
      "En attente",
      "Traitement",
      "Terminée",
    ];

    return Row(
      children: List.generate(steps.length, (index) {
        final active = index <= t.status.index;

        return Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor:
                active ? Theme.of(context).primaryColor : Colors.grey.shade300,
                child: active
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 6),
              Text(
                steps[index],
                style: TextStyle(
                  fontSize: 11,
                  color: active ? Theme.of(context).primaryColor : Colors.grey,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
class _WalletSection extends StatelessWidget {
  final Transaction t;

  const _WalletSection(this.t);

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: "Adresse Wallet",
      child: SelectableText(t.walletAddress),
    );
  }
}

class _BlockchainSection extends StatelessWidget {
  final Transaction t;

  const _BlockchainSection(this.t);

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: "Blockchain",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(t.txHash),
          const SizedBox(height: 6),
          TextButton(
            onPressed: () {
              // launchUrl(TronScan)
            },
            child: const Text("Voir sur TronScan"),
          )
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

/*class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EEF3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Détails",
          style: TextStyle(
            color: Color(0xFF3D2A3A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _row("Type", transaction.type),
              _row("Montant",
                  "${transaction.amount}"),
                //  "${transaction.amount} ${transaction.currency}"),
              _row("Statut", transaction.status),
              _row("Paiement", transaction.paymentMethod),
              _row(
                "Date",
                transaction.date,
               // transaction.date.toLocal().toString(),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF6B300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Retour"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
*/