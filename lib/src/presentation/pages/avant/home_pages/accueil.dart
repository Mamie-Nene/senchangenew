
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:provider/provider.dart';

import '/src/config/router_observer.dart';
import '/src/data/remote/transaction/transaction_api.dart';
import '/src/data/local/operation_card_data.dart';
import '/src/domain/notification_model.dart';
import '/src/domain/TransactionEntity.dart';

import '/src/services/notification_storage_service.dart';
import '/src/services/utils.service.dart';

import '/src/methods/transform_format_methods.dart';
import '/src/presentation/widgets/offre_exclusive_carousel.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';


class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> with RouteAware {

  List<Map<String, dynamic>> notificationsInStorage = [];

  List<TransactionEntity> transactions = [];

  bool isLoading = true;

  getHistoriqueTransaction(BuildContext context) async {
    await TransactionApi().getHistoriqueTransactions(context).then(
            (value) {
              setState(() {
                transactions = value;
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

  getNotificationsInStorage() async {
    List<Map<String, dynamic>> notifs = await NotificationStorageService.getNotifications();
    setState(() {
      notificationsInStorage = notifs;
    });
   // print(await SecureStorageService.getToken("access_token"));

  }

  @override
  void initState() {

    getHistoriqueTransaction(context);
    getNotificationsInStorage();

    super.initState();

  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      debugPrint("routeObserver.subscribe OK");
      routeObserver.subscribe(this, route);
    }
  }

  chooseTransactionDetailPage(TransactionEntity transaction,BuildContext context){
    switch (transaction.typeTransaction) {
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
  chooseTransactionDetailPageAvant(TransactionEntity transaction,BuildContext context){
    switch (transaction.typeTransaction) {
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

  @override
  Widget build(BuildContext context) {
    List<dynamic> notifications = context.watch<NotificationModel>().notifications;

    final bool tablet = AppDimensions().isTablet(context);
    return Scaffold(

      backgroundColor: AppColors.bgColor,

      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        leading://Builder
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutesName.parametrePage);
              },
            icon: Icon(Icons.settings, color: AppColors.textGrisColor),
          ),
        ),
        actionsPadding:const EdgeInsets.only(right: 20),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutesName.notifPage);
            },
            child: Badge(
              backgroundColor: notifications.isNotEmpty || notificationsInStorage.isNotEmpty ? AppColors.orangeColor : Colors.transparent,
              child: Icon(Icons.notifications, color: AppColors.textGrisColor),
            ),

          ),

        ],
      ),

      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection:Axis.horizontal,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/4,
                 // width:MediaQuery.of(context).size.width,

                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: OperationCardLocalData().labels.length ,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),

                    itemBuilder: (BuildContext context, int index) {
                      return _homeCard(
                        context,  tablet,
                          iconUrl:OperationCardLocalData().iconUrls[index],
                          label:OperationCardLocalData().labels[index],
                          backgroundColor:OperationCardLocalData().backgroundColors[index],
                          icon:OperationCardLocalData().icons[index],
                          destination:OperationCardLocalData().destinations[index],
                          linearTopColors: OperationCardLocalData().linearTopColors[index],
                          linearBottomColors: OperationCardLocalData().linearBottomColors[index]
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2 ,//nbre de ligne
                        crossAxisSpacing:MediaQuery.of(context).size.height/63,// 13,
                        mainAxisSpacing: MediaQuery.of(context).size.width/30.5,//13,
                        mainAxisExtent:  MediaQuery.of(context).size.width/2.3//170, //MediaQuery.of(context).size.width / 1.9 :
                    ),
                  ),
               ),
              ),

              SizedBox(height: AppDimensions.h10(context)),

              OffreExclusiveCarousel(),

              SizedBox(height: AppDimensions.h10(context)),

               Text(
                "Transactions récentes",
                style: TextStyle(
                  fontSize: AppDimensions().responsiveFont(context,20),
                  color: AppColors.textGrisColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: AppDimensions.h10(context)),

              Expanded(
                child: Builder(
                  builder: (context){
                    if (isLoading) {
                      return _buildSkeletonList();
                    }
                    if (transactions.isEmpty) {
                      return Center(
                        child: Text(
                          "Pas de transaction pour le moment!",
                          style: TextStyle(fontSize: AppDimensions().responsiveFont(context,16), fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                    return _buildListTransaction(transactions);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildListTransaction(List<TransactionEntity> transactions ){

    return  ListView.builder(
      itemCount:  transactions.length,
      itemBuilder: ( context, index) {
        TransactionEntity transaction = transactions[index];

        return GestureDetector(
            onTap: () {
              chooseTransactionDetailPageAvant(transaction,context);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                         Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.grisBackgroundColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child:  Icon(Icons.wallet, color: AppColors.textGrisColor,),
                          ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transaction.typeTransaction == "VENTE" || transaction.typeTransaction == "ACHAT" ? transaction.typeTransaction : "ECHANGE",
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions().responsiveFont(context,15),
                              ),
                          ),
                              SizedBox(height: AppDimensions.h5(context)),
                              Text(TransformationFormatMethods.formatDateInFrench(transaction.dateTransaction,),
                                style: TextStyle(
                                  color: AppColors.grisClair,
                                  fontSize: AppDimensions().responsiveFont(context,15)
                                )
                                ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(TransformationFormatMethods.formatTransationInitCurrency(transaction.amountInit, transaction.typeTransaction,),
                        style:  TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.h5(context)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: UtilsService.getTransactionColor(transaction.statusTransaction,).withAlpha((0.1 * 255).toInt()),
                          borderRadius: BorderRadius.circular(5,),
                        ),
                        child:Text(
                           TransformationFormatMethods.formatTransactionStatus(transaction.statusTransaction,),
                            style: TextStyle(
                              color: UtilsService.getTransactionColor(transaction.statusTransaction),
                             // color: UtilsService.getTransactionLabelColor(transaction.statusTransaction,),
                              fontSize: AppDimensions().responsiveFont(context,14,)
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
       /* return GestureDetector(
            onTap: () {
              chooseTransactionDetailPage(transaction,context);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                         Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.grisBackgroundColor,
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child:  Icon(Icons.wallet, color: AppColors.textGrisColor,),
                          ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transaction.typeTransaction == "VENTE" || transaction.typeTransaction == "ACHAT" ? transaction.typeTransaction : "ECHANGE",
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppDimensions().responsiveFont(context,15),
                              ),
                          ),
                              SizedBox(height: AppDimensions.h5(context)),
                              Text(TransformationFormatMethods.formatDateInFrench(transaction.dateTransaction,),
                                style: TextStyle(
                                  color: AppColors.grisClair,
                                  fontSize: AppDimensions().responsiveFont(context,15)
                                )
                                ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(TransformationFormatMethods.formatTransationInitCurrency(transaction.amountInit, transaction.typeTransaction,),
                        style:  TextStyle(
                          fontSize: AppDimensions().responsiveFont(context,15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.h5(context)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: UtilsService.getTransactionColor(transaction.statusTransaction,).withAlpha((0.1 * 255).toInt()),
                          borderRadius: BorderRadius.circular(5,),
                        ),
                        child:Text(
                           TransformationFormatMethods.formatTransactionStatus(transaction.statusTransaction,),
                            style: TextStyle(
                              color: UtilsService.getTransactionColor(transaction.statusTransaction),
                             // color: UtilsService.getTransactionLabelColor(transaction.statusTransaction,),
                              fontSize: AppDimensions().responsiveFont(context,14,)
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );*/
      },
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

  Widget _homeCard(BuildContext context, bool isTablet,{
    required String iconUrl,
    required String label,
    required Color backgroundColor,
    required IconData icon,
    required String destination,
    required Color linearTopColors,
    required Color linearBottomColors,
  }){


    return GestureDetector(
      onTap: () {Navigator.of(context).pushNamed(destination);},
      child: Container(
        padding: const EdgeInsets.all(8.0),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isTablet?24:15),
          gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            linearTopColors,
            linearBottomColors
          ],
        ),
        ),
        child:  SingleChildScrollView(
          child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: backgroundColor,
                  radius: isTablet? 35 : 25,
                  foregroundColor: AppColors.textGrisColor,
                  child: Center(child: Icon(icon, size: isTablet?40:30)),
                ),
              // Image.asset("assets/images/icons/$iconUrl"),
                SizedBox(height: AppDimensions.h10(context)),
                Text(label,
                  style: TextStyle(
                    fontSize: AppDimensions().responsiveFont(context,16),
                    fontWeight: FontWeight.w800,
                    color: AppColors.textGrisColor,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
   }
}
/*class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = [
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
      backgroundColor: Colors.black,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, index) => TransactionCard(item: list[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: list.length,
      ),
    );
  }
}*/
