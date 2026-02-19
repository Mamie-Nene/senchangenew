import 'package:flutter/material.dart';
import '/src/presentation/widgets/app_utils.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';

import '/src/domain/NewTransactionEntity.dart';


class TransactionDetailScreen extends StatelessWidget {
  final  NewTransactionEntity transaction;

  const TransactionDetailScreen({super.key, required this.transaction,});

  @override
  Widget build(BuildContext context) {
    final statusTransaction = AppUtilsWidget().getTransactionStatusTranslated(transaction.status);
    return Scaffold(
      backgroundColor: Colors.white,
     // backgroundColor: const Color(0xFFF6EEF3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        //backgroundColor: const Color(0xFFF6EEF3),
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
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statusBadge(context,statusTransaction ),
                _typeTransactionBadge(context, transaction.transaction_type),
              ],
            ),
            _amountCard(context, t: transaction),
            SizedBox(width: Size.infinite.width, child: _infoTile(context, label:"Référence",value:  transaction.reference_code,iconData: null)),
            _infoGrid(context,t:transaction),
          //  _statusTimeline(context,t:transaction),
            SizedBox(
              width: Size.infinite.width,
              child: _infoTile(context, label:"Adresse Wallet",value:  transaction.wallet_address,iconData: Icons.wallet),
            ),

            SizedBox(
              width: Size.infinite.width,
              child: _infoTile(context, label:"Traçabilté Blockchain",value:  transaction.txid,iconData: Icons.link),
            ),
          ],
        ),
      ),
    );
  }
  Widget _statusBadge(BuildContext context,String status) {
    final isCompleted = status == "Terminée";
    Color color;

    switch (status) {
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.access_time,
          size: 18,
          color: color,
          ),
        const SizedBox(width: 8),
        Text(status,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        ],
      ),
    );
  }
  Widget _typeTransactionBadge(BuildContext context, String typeTransaction) {
    final icon = AppUtilsWidget().getTransactionTypeIcon(typeTransaction) ;

    final typeTransactionTranslated = AppUtilsWidget().getTransactionTypeTranslated(transaction.transaction_type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: icon.color!.withOpacity(.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
        const SizedBox(width: 8),
        Text(typeTransactionTranslated,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: icon.color
          ),
        ),
        ],
      ),
    );
  }

  Widget _amountCard(BuildContext context,{required  NewTransactionEntity t}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColors.secondAppColor.withOpacity(.08),
            //Theme.of(context).primaryColor.withOpacity(.08),
            Colors.transparent,
          ],
        ),
        border: Border.all(color: AppColors.secondAppColor.withOpacity(.15)),
      //  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.15)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      t.from_amount.toStringAsFixed(0),
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(color:  AppColors.mainAppTextColor,fontWeight: FontWeight.bold),
                    ),
                    Text(t.from_currency, style: TextStyle(color:  AppColors.secondAppColor,fontWeight: FontWeight.bold) ),
                  ],
                ),
              ),

              CircleAvatar(
                backgroundColor: AppColors.secondAppColor.withOpacity(0.1),
                child: Icon(Icons.arrow_forward,color: AppColors.secondAppColor,),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      t.to_amount.toStringAsFixed(2),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColors.secondAppColor,fontWeight: FontWeight.bold),
                    ),
                    Text(t.to_currency,style: TextStyle(color: AppColors.secondAppColor,fontWeight: FontWeight.bold)),
                  ],
              ),
            ),
            ],
          ),
          Divider(color: AppColors.secondAppColor.withOpacity(0.15),),

          Text('Taux : 1 USDT = ${t.exchange_rate} XOF',style: TextStyle(color: AppColors.mainAppTextColor),)

        ],
      ),
    );
  }

  Widget _infoGrid(BuildContext context,{required  NewTransactionEntity t}) {
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
        _infoTile(context, label:"Date",value:  t.created_at.substring(0,16),  iconData: Icons.date_range),
        _infoTile(context,label:"Méthode de paiement", value: t.payment_method,iconData:Icons.wallet),
        _infoTile(context,label:"Réseau", value: t.blockchain, iconData: Icons.insert_link),
        _infoTile(context,label:"Téléphone", value: t.phone_number, iconData: Icons.phone),
        _infoTile(context,label:"Frais", value: t.fee_amount.toString(), iconData: Icons.attach_money),
      ],
    );
  }

  Widget _infoTile(BuildContext context,{required  String label, required String value, required IconData? iconData}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainAppColor.withOpacity(0.1)) ,
        color: AppColors.mainAppColor.withOpacity(0.05),
       // color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          iconData!=null? Icon(iconData,color: AppColors.mainAppColor,):Text('#'),
          SizedBox(width: 5,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 4),
                Text(value,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTimeline(BuildContext context,{required  NewTransactionEntity t}) {
    final steps = [
      "Créée",
      "En attente",
      "Traitement",
      "Terminée",
    ];

    return Row(
      children: List.generate(steps.length, (index) {
        final active = t.status == steps[index];
        // final active = t.status == TransactionStatus.values[index];
        //final active = index <= t.status.index;

        return Expanded(
          child: Column(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor:
                active ? Theme
                    .of(context)
                    .primaryColor : Colors.grey.shade300,
                child: active
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(height: 6),
              Text(
                steps[index],
                style: TextStyle(
                  fontSize: 11,
                  color: active ? Theme
                      .of(context)
                      .primaryColor : Colors.grey,
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _walletSection (BuildContext context,{required  NewTransactionEntity t}) {
      return _sectionCard(context,
        title: "Adresse Wallet",
        child: SelectableText(t.wallet_address),
      );
  }

  Widget _blockchainSection (BuildContext context,{required NewTransactionEntity t}) {
    return _sectionCard(context,title: "Blockchain", child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SelectableText("0X1222"),
  // SelectableText(t.txHash),
  const SizedBox(height: 6),
  TextButton(
  onPressed: () {
  // launchUrl(TronScan)
  },
  child: const Text("Voir sur TronScan"),
  )
  ],
  ),);
  }

  Widget _sectionCard (BuildContext context, {required String title, required Widget child,}) {
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
                    backgroundColor: AppColors.secondAppColor,
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