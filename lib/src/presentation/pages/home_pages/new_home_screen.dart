import 'package:flutter/material.dart';
import 'package:senchange/src/data/remote/transaction/transaction_api.dart';
import 'package:senchange/src/presentation/pages/home_pages/accueil.dart';
import 'package:senchange/src/presentation/widgets/transaction_newdetail_widget.dart';
import 'package:senchange/src/utils/consts/app_specifications/allDirectories.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/src/presentation/pages/operation_part/detailTransaction_new.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TransactionItem> transactionitems = [
  ];

  bool isLoading = false;
  chooseTransactionDetailPage(TransactionItem transaction,BuildContext context){
    switch (transaction.type) {
      case "VENTE":
        return Navigator.of(context).pushNamed(AppRoutesName.venteDetailsPage,
            arguments: {
              "transaction":transaction
            }
        );
      case "ACHAT":
        return Navigator.of(context).pushNamed(AppRoutesName.achatDetailsPage,
            arguments: {
              "transaction":transaction
            }
        );
      default:
        return Navigator.of(context).pushNamed(AppRoutesName.echangeDetailsPage,
            arguments: {
              "transaction":transaction
            }
        );
    }
  }

  getHistoriqueTransaction(BuildContext context) async {
    await TransactionApi().getHistoriqueTransactionsNew(context).then(
            (value) {
          setState(() {
            transactionitems = value;
            isLoading = false;
          });
        }
    ).onError((error, stackTrace) {
      if(!mounted) return;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
   //
    // getHistoriqueTransaction(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<TransactionItem> transactionitems = [
      TransactionItem(
        type: "Achat",
        status: "Annulée",
        amount: "10 000 XOF → 17,573 USDT",
        date: "05 janv. 2026 à 15:14",
        network: "BEP20",
        fee: "100 CFA",
        reference: "SEN-2331CDB3-20260105",
        provider: "Wave",
        isBuy: true,
      ),
      TransactionItem(
        type: "Achat",
        status: "Annulée",
        amount: "10 000 XOF → 17,573 USDT",
        date: "05 janv. 2026 à 15:14",
        network: "BEP20",
        fee: "100 CFA",
        reference: "SEN-2331CDB3-20260105",
        provider: "Wave",
        isBuy: true,
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF6EEF3),
      // backgroundColor: const Color(0xFFFAEAF4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6B300).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.settings, color: Colors.black87),//Colors.white70
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color:  Color(0xFFF6B300).withOpacity(0.4),
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AppRoutesName.updateProfilPage);
                        },
                        icon:Icon(Icons.person, color: Colors.black87, ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 18),
//TextButton(onPressed: (){TransactionApi().getHistoriqueTransactionsNew(context);}, child: Text('test')),
              // Grid Menu
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.3,
                children:[
                  ActionButton(
                    icon: Icons.shopping_bag_outlined,
                    label: "Achat",
                   firstGradientColor:  Color(0xFFFDE047), // yellow-300
                    secondGradientColor: Color(0xFFFACC15), // yellow-400
                   boxIconColor:  Color(0xFFF59E0B).withOpacity(0.8), // yellow-500/80
                    iconColor: const Color(0xFF78350F), // yellow-900,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.acheterPage);
                    },
                  ),
                  ActionButton(
                    icon: Icons.local_offer_outlined,
                    label: "Vente",
                    firstGradientColor:    Color(0xFFFBCFE8), // pink-200
                    secondGradientColor: Color(0xFFF9A8D4), // pink-300
                    boxIconColor: const Color(0xFFF472B6).withOpacity(0.8), // pink-400/80,
                    iconColor: const Color(0xFF9D174D), // pink-800,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.vendrePage);
                    },
                  ),
                  ActionButton(
                    icon: Icons.refresh,
                    label: "Échange",
                    firstGradientColor:    Color(0xFF6EE7B7), // emerald-300
                    secondGradientColor:  Color(0xFF4ADE80), // green-400
                    boxIconColor: const Color(0xFF10B981).withOpacity(0.8), // emerald-500/80,
                    iconColor: const Color(0xFF064E3B), // emerald-900,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.echangePage);
                    },
                  ),
                  ActionButton(
                    icon: Icons.account_balance_wallet_outlined,
                    label: "Mes wallets",
                    firstGradientColor:  Color(0xFFD9F99D), // lime-200
                    secondGradientColor:  Color(0xFFFEF08A), // yellow-200
                    boxIconColor: const Color(0xFF84CC16).withOpacity(0.8), // lime-500/80,
                    iconColor: const Color(0xFF3F6212), // lime-800,
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutesName.walletsPage);
                    },
                  ),
                 // _MenuCard(title: "Achat", icon: Icons.shopping_cart, color: Color(0xFFF6B300)),
                 // _MenuCard(title: "Vente", icon: Icons.attach_money, color: Color(0xFFFF66B2)),
                 // _MenuCard(title: "Échange", icon: Icons.swap_horiz, color: Color(0xFF3CCB7F)),
                 // _MenuCard(title: "Mes wallets", icon: Icons.account_balance_wallet, color: Color(0xFFB58BFF)),
                ],
              ),
              /*
              * GridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: 12,
  crossAxisSpacing: 12,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  children: [
    ActionButton(
      icon: Icons.shopping_bag_outlined,
      label: "Achat",
      onTap: () {},
    ),
    ActionButton(
      icon: Icons.swap_horiz,
      label: "Vente",
      onTap: () {},
    ),
  ],
),
*/
              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Transactions récentes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF3D2A3A),
                    ),
                  ),
                  TextButton(
                      onPressed: () {Navigator.of(context).pushNamed(AppRoutesName.transactiionOperationPage);},
                      child: Text("Voir Tout"))
                ]
              ),

              const SizedBox(height: 10),

            /*  Expanded(
                child: ListView(
                  children: const [
                    _TransactionTile(
                      type: "ACHAT",
                      time: "il y a 3 jours",
                      amount: "190.0 USDT",
                      status: "rejetée",
                      statusColor: Colors.red,
                    ),
                    _TransactionTile(
                      type: "ACHAT",
                      time: "il y a 4 jours",
                      amount: "100.0 USDT",
                      status: "acceptée",
                      statusColor: Colors.green,
                    ),
                    _TransactionTile(
                      type: "ACHAT",
                      time: "il y a 5 jours",
                      amount: "1500.0 USDT",
                      status: "acceptée",
                      statusColor: Colors.green,
                    ),
                    _TransactionTile(
                      type: "VENTE",
                      time: "il y a 6 jours",
                      amount: "100.0 USDT",
                      status: "acceptée",
                      statusColor: Colors.green,
                    ),
                  ],
                ),
              ),*/
              Expanded(
                child: Builder(
                  builder: (context){
                  /* if (isLoading) {
                      return _buildSkeletonList();
                    }*/
                    if (transactionitems.isEmpty) {
                      return Center(
                        child: Text(
                          "Pas de transaction pour le moment!",
                          style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16), fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                    return _buildListTransaction(transactionitems);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSkeletonList() {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        itemCount: 5, // dummy skeleton items
        itemBuilder: (context, index) {
          return  Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            // height: 80, // fixed height for skeleton effect
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.wallet, color: AppColors.textGrisColor),
                    const SizedBox(width: 15),
                    Text("Type",
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppDimensions().responsiveFont(context,16),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("date",
                        style: TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.h5(context)),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5,),
                        decoration: BoxDecoration(
                          color: AppColors.transactionAcceptedColor,
                          borderRadius: BorderRadius.circular(5,),
                        ),
                        child: Text("data",
                          style: TextStyle(
                            color:Colors.green,
                            fontSize: AppDimensions().responsiveFont(context,14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder:(context, index) {
          return const SizedBox( height: 10,);
        },
      ),
    );
  }
  Widget _buildListTransaction(List<TransactionItem> transactions ){

    return  ListView.builder(
      itemCount:  transactions.length,
      itemBuilder: ( context, index) {
        TransactionItem transaction = transactions[index];
        final iconColor = transaction.isBuy ? Colors.green : Colors.red;
        final icon = transaction.isBuy ? Icons.arrow_downward : Icons.arrow_upward;

        return   InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            chooseTransactionDetailPage(transaction,context);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFF3D2A3A).withOpacity(0.2)),
              color: Color(0xffECDCEC)
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
                          color:Color(0xFF3D2A3A).withOpacity(.2),
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
                                  transaction.type,
                                  style: const TextStyle(
                                    color: Color(0xFF3D2A3A),
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 8),
                                StatusBadge(transaction.status),
                              ],
                            ),

                            const SizedBox(height: 4),

                            /// AMOUNT
                            Text(
                              transaction.amount,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF3D2A3A)),
                            ),

                            const SizedBox(height: 4),

                            /// CHIPS ROW
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                Text(transaction.date,
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF3D2A3A))),
                                InfoChip(transaction.network, Colors.blue),
                                InfoChip("Frais: ${transaction.fee}", Colors.orange),
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
                          transaction.reference,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF3D2A3A),
                            fontFamily: "monospace",
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "via ${transaction.provider}",
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
      },
    );
  }

}

class _MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _MenuCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {Navigator.of(context).pushNamed(AppRoutesName.acheterPage);},

      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3D2A3A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final String type;
  final String time;
  final String amount;
  final String status;
  final Color statusColor;

  const _TransactionTile({
    required this.type,
    required this.time,
    required this.amount,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    //TransactionModel transactionModel = TransactionModel(id:"1", type: type, amount: amount, status: status, date: "3 fev", paymentMethod: "Wave");
    Transaction transaction = Transaction(reference: "12344", amountXof: 100.0, amountUsdt: 1000.0, paymentMethod: "Wave", network: "BEP20", walletAddress: "0X1222", txHash: "0X1222", createdAt: DateTime(2025, 1, 1), completedAt: DateTime(2025, 1, 1), status:TransactionStatus.completed);
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(AppRoutesName.detailTransactionPage,
            arguments: {
              "transaction":transaction
             // "transaction":transactionModel
            });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.description, color: Colors.white70),
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
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
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
                    color: Color(0xFF3D2A3A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: statusColor,
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


class ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color firstGradientColor;
  final Color secondGradientColor;
  final Color boxIconColor;
  final Color iconColor;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.firstGradientColor,
    required this.secondGradientColor,
    required this.boxIconColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          decoration: BoxDecoration(
            gradient:  LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.firstGradientColor,
               widget.secondGradientColor,
              ],
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: _hovered
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
            ]
                : [],
          ),
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints(minHeight: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: _hovered ? 1.1 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Container(
                  padding:  EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:widget.boxIconColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 22,
                    color: widget.iconColor
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
