
import 'package:flutter/material.dart';
import '/src/domain/TransactionEntity.dart';

import '/src/utils/consts/constants.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import 'custom_elavated_button.dart';

class TransactionDetailsWidgets {

  detailPart({
    required BuildContext context,
    required String title,
    required String subtitle,
    required TransactionEntity transactionEntity,
    required Widget columnWidget,
    required VoidCallback annulerAction,
    required VoidCallback relancerAction
  }){
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(title,
            style: TextStyle(fontSize: AppDimensions().responsiveFont(context,18), fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppDimensions.h10(context)),
          Text(subtitle,
            style: TextStyle(
              fontSize: AppDimensions().responsiveFont(context,22),
              fontWeight: FontWeight.bold,
              color: AppColors.orangeColor,
            ),
          ),
          SizedBox(height: AppDimensions.h20(context)),
          Container(
            margin: const EdgeInsets.only(bottom:15),
            padding: const EdgeInsets.only(bottom:15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              ),
            child: columnWidget
            ),

          // btns de relance & d'annulation : transaction en attente
          if (transactionEntity.statusTransaction == Constants.statutTransactionEnCours) ...[
            /*Expanded(
              child:*/operationOnTransactionPart(
                  context: context,
                  annulerAction: annulerAction,
                  relancerAction:relancerAction
              ),
           // )
          ],
        ],
      ),
    );
  }

  operationOnTransactionPart( {
    required BuildContext context,
    required VoidCallback annulerAction,
    required VoidCallback relancerAction
  }){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: CustomElevatedButton(
                  label: "Annuler",
                  // color: Color.fromARGB(255, 201, 200, 200),
                  color: AppColors.rougeColor,
                  textColor: Colors.white,
                  action: () { annulerTransactionBottomSheet(context,annulerAction);},

              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: CustomElevatedButton(
                  label: "Relancer",
                  color: AppColors.orangeColor,
                  textColor: Colors.black,
                  action: () { relancerTransactionBottomSheet(context,relancerAction);},
              ),
            ),
          ],
        ),
      ],
    );
  }

  annulerTransactionBottomSheet(BuildContext context,VoidCallback annulerAction){
    return transactionActionBottomSheet(context, "Vous êtes sur le point d'annuler cette transaction. Voulez-vous continuer ?",annulerAction);
  }

  relancerTransactionBottomSheet(BuildContext context,VoidCallback relancerAction){
    return transactionActionBottomSheet(context, "Vous êtes sur le point de relancer cette transaction. Voulez-vous continuer ?", relancerAction);
  }

  transactionActionBottomSheet(BuildContext context, String title, VoidCallback action){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppDimensions().responsiveFont(context,18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: AppDimensions.h20(context)),
                  CustomElevatedButton(
                    label: "Oui",
                    color: AppColors.orangeColor,
                    action: action,
                    textColor: Colors.black,
                  ),

                  SizedBox(height: AppDimensions.h15(context)),

                  CustomElevatedButton(
                    label: "Non",
                    color: AppColors.textGrisSecondColor,
                    action: () {
                      Navigator.pop(context);
                    },
                    textColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  rowForTransactionOperationDetails(String rowTitle, String value,BuildContext context){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(rowTitle,
          style: TextStyle(
            fontSize: AppDimensions().responsiveFont(context,16),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value,
          style: TextStyle(
            fontSize: AppDimensions().responsiveFont(context,16),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

}
