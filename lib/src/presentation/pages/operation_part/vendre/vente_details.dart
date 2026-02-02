
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../methods/response_messages.dart';
import '/src/domain/TransactionEntity.dart';
import '/src/data/local/transaction_steps.dart';
import '/src/data/remote/transaction/transaction_api.dart';

import '/src/methods/transform_format_methods.dart';
import '/src/services/utils.service.dart';

import '/src/presentation/widgets/transaction_detail_widgets.dart';
import '/src/presentation/widgets/hrizontal_timeline_process.dart';

import '/src/utils/consts/app_specifications/allDirectories.dart';



class VenteDetails extends StatefulWidget {
  final TransactionEntity transaction;
  const VenteDetails({super.key, required this.transaction});

  @override
  State<VenteDetails> createState() => _VenteDetailsState();
}

class _VenteDetailsState extends State<VenteDetails> {

  List<Map<String, dynamic>> steps=TransactionLocalData().steps;

  bool isTimeLineComplete = false;

  int? currentStep;

  @override
  void initState() {
    super.initState();
    getStatutTransaction(widget.transaction.statusTransaction);
  }

  getCurrentState(String statutTransaction){
    switch (statutTransaction) {
      case "WAITING_OTP":
        return -1;

      case "INIT":
        return 1;

      case "PENDING":
        return 2;

      case "ACCEPTED":
        return 3;

      default:
        return 3;
    }
  }

  getStatutTransaction(String transactionStatus) async {

    setState(() {
      currentStep = getCurrentState(transactionStatus);
    });
    if (transactionStatus == "REJECTED") {
      setState(() {
        currentStep = 3;
        steps[3]["title"] = "Rejetée";
        steps[3]["icon"] = Icons.close;
        steps[3]["color"] = AppColors.transactioRejectedColor;
      });
    }

    setState(() {
      isTimeLineComplete = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppBar(backgroundColor: AppColors.bgColor, title: Text("Détails")),

      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: TransactionDetailsWidgets().detailPart(
                title: "Vous avez vendu",
                subtitle: "${widget.transaction.amountInit} USDT",
                context: context,
                transactionEntity: widget.transaction,
                columnWidget: Column(
                    children: [
                      ListTile(
                        title: Text("Montant total"),
                        trailing: Text(
                          // "${widget.transaction["amountChange"].toString()} FCFA",
                          "${TransformationFormatMethods.formatCurrencyAmount(widget.transaction.amountChange.toString())} FCFA",
                          style: TextStyle(
                            fontSize: AppDimensions().responsiveFont(context,15),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Paiement via"),
                        trailing: Text(
                          "${widget.transaction.operator}",
                          style: TextStyle(
                            fontSize: AppDimensions().responsiveFont(context,15),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Sur le numéro"),
                        trailing: Text(
                          "${widget.transaction.phoneNumber}",
                          style: TextStyle(
                            fontSize: AppDimensions().responsiveFont(context,15),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Date"),
                        trailing: Text(
                          TransformationFormatMethods.formatDateInFrench(
                            widget.transaction.dateTransaction,
                          ),

                          style: TextStyle(
                            fontSize: AppDimensions().responsiveFont(context,15),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Portefeuille utilisé"),
                        trailing: Text(
                          TransformationFormatMethods.truncateWithEllipsis(10,
                            widget.transaction.addressWallet!,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: AppDimensions().responsiveFont(context,15),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ListTile(
                        // contentPadding: EdgeInsets.only(left: 0),
                        title: Text("Portefeuille à créditer"),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                TransformationFormatMethods.truncateWithEllipsis(
                                  10, widget.transaction.addressOwner!,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: AppDimensions().responsiveFont(context,15),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: widget.transaction.addressOwner!,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  ResponseMessageService().getSnackBarForSuccessReturn(context,"Numéro de wallet copié !")
                                );
                              },
                              icon: Icon(Icons.copy),
                            ),
                          ],
                        ),

                      ),
                      ListTile(
                        title: Text("Etat de la transaction"),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: UtilsService.getTransactionColor(widget.transaction.statusTransaction).withAlpha((0.1 * 255).toInt()),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 5,
                            ),
                            child: Text(
                              TransformationFormatMethods.formatTransactionStatus(
                                widget.transaction.statusTransaction,
                              ),

                              style: TextStyle(
                                fontSize: AppDimensions().responsiveFont(context,15),
                                fontWeight: FontWeight.w400,
                                color: UtilsService.getTransactionColor(widget.transaction.statusTransaction,),
                                //color: UtilsService.getTransactionLabelColor(widget.transaction.statusTransaction,),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // timeline
                      if (currentStep != null && isTimeLineComplete)
                        HorizontalProcessTimeline(
                          currentStep: currentStep!,
                          steps: steps,
                        ),
                    ],
                  ),
                annulerAction: () async {
                  await TransactionApi().cancelWaitingTransaction(context,widget.transaction);
                },
                relancerAction:() async {
                //  await TransactionApi().loadAgainWaitingTransaction(context,"vente",widget.transaction);
                },

          ),
        ),
      ),
    );
  }
}
