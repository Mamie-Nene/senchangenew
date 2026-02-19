import 'package:flutter/material.dart';
import '/src/data/local/operation_card_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/src/data/local/transaction_local_data.dart';
import '/src/presentation/widgets/app_utils.dart';

import '/src/data/remote/transaction/transaction_api.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/domain/NewTransactionEntity.dart';
import '/src/utils/consts/routes/app_routes_name.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewTransactionEntity> transactionitems = [];
  bool isLoading = false;

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
    List<NewTransactionEntity> transactions = TransactionLocalData().transactions;
    List<ActionButton> actions = OperationCardLocalData().actions;

    return Scaffold(

     // backgroundColor: AppColors.mainBgColor,
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
                      color: AppColors.secondAppColor.withOpacity(0.2),
                      border: Border.all(color: AppColors.secondAppColor),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child:  Icon(Icons.settings, color: AppColors.secondAppColor),//Colors.white70
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.secondAppColor.withOpacity(0.2),
                      border: Border.all(color: AppColors.secondAppColor),
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed(AppRoutesName.updateProfilPage);
                        },
                        icon:Icon(Icons.person, color: AppColors.secondAppColor, ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              //TextButton(onPressed: (){TransactionApi().getHistoriqueTransactionsNew(context);}, child: Text('test')),
              // Grid Menu
              GridView.builder(
                itemCount: actions.length,
                physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 1.3,
                ),

                itemBuilder:(context, index) {
                  return actions[index];
                }
              ),

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
                      child: Text("Voir Tout",style: TextStyle(color: AppColors.mainAppColor),))
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
                    if (transactions.isEmpty) {
                      return Center(
                        child: Text(
                          "Pas de transaction pour le moment!",
                          style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16), fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                    return AppUtilsWidget().buildListTransaction(transactions, true);
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
}

class ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color firstGradientColor;
  final Color secondGradientColor;
  final Color boxIconColor;
  final Color iconColor;
  final String route;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.firstGradientColor,
    required this.secondGradientColor,
    required this.boxIconColor,
    required this.iconColor,
    required this.route,
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
        onTap:() {
          Navigator.of(context).pushNamed(widget.route);
        },
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
