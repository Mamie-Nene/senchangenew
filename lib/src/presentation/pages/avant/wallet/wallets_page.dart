
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '/src/domain/WalletEntity.dart';

import '/src/presentation/widgets/custom_elavated_button.dart';
import '/src/presentation/widgets/main_button.dart';
import '/src/presentation/widgets/app_app_bars.dart';

import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/data/remote/wallet/wallet_api.dart';


class WalletsPage extends StatefulWidget {
  const WalletsPage({super.key});

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  List<WalletEntity> wallets = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    getWallets(context);
  }

  // recuperer la list des wallets de l'utilisateur connecté
  getWallets(BuildContext context) async {
     await WalletApi().getWallets(context).then((value) {
       setState(() {
         wallets = value;
         isLoading = false;
       });
     }).onError((error, stackTrace) {
       setState(() {
         isLoading = false;
       });
     });
  }

  desactiverWalletBottomSheet(BuildContext context, walletId, int index){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context,).size.height * 0.3, // 50% de l'écran
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
                  Text(AppText.DESACTIVATION_WALLET_TEXT,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppDimensions().responsiveFont(context,18),
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: AppDimensions.h20(context)),

                  CustomElevatedButton(
                    label: "Oui",
                    color: AppColors.orangeColor,
                    action: () async {
                      // archivage du wallet
                       await WalletApi().archiveWallet(context, walletId, "désactiver", index,).then((value) {
                         setState(() {wallets[index].actif =value;});
                       });
                    },
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

  activerWalletBottomSheet(BuildContext context,walletId, int index){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Permet de contrôler la hauteur
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context,).size.height * 0.3, // 50% de l'écran
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Vous êtes sur le point d'activer ce portefeuille. Voulez-vous continuer ?",
                    softWrap: true,
                    textAlign:
                    TextAlign.center,
                    style: TextStyle(
                      fontSize: AppDimensions().responsiveFont(context,18),
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: AppDimensions.h20(context)),
                  CustomElevatedButton(
                    label: "Oui",
                    color: AppColors.orangeColor,
                    action: () async {
                      // archivage du wallet
                      await WalletApi().archiveWallet(context, walletId, "activer", index,).then((value) {
                        setState(() {
                          wallets[index].actif =value;
                        });
                        // wallets[index]["actif"] = true;
                      });
                    },
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

  @override
  Widget build(BuildContext context) {
    WalletEntity mockEntity=WalletEntity(0, "mywallet", "6775e0eb-e7cf-40fc-bbac-03e776192f15", "nameBlockchain", "blockChainType", true);

    return Scaffold(
      backgroundColor: AppColors.bgColor,

      appBar: AppAppBars(title:"Mes portefeuilles" , action: () {Navigator.of(context).pushNamed(AppRoutesName.accueilPage);},),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {Navigator.of(context).pushNamed( AppRoutesName.addWalletPage);},
                child: MainButton(
                  backgroundColor: AppColors.orangeColor,
                  label: "Ajouter un portefeuille",
                ),
              ),

              SizedBox(height: AppDimensions.h10(context)),

               Text("Mes portefeuilles",
                style: TextStyle(fontSize: AppDimensions().responsiveFont(context,18), fontWeight: FontWeight.bold),
              ),

              SizedBox(height: AppDimensions.h10(context)),
              Expanded(
                child: Builder(
                  builder: (context){
                    if (isLoading) {
                      return _buildSkeletonList();
                    }
                    if (wallets.isEmpty) {
                      return const Center(
                        child: Text(
                          "Pas de portefeuille pour le moment!",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                    return _buildWalletList(wallets);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  walletCard(String walletName, String walletAdresse, bool walletState,){
    return Expanded(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: AppColors.grisBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: AppColors.textGrisColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(walletName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: AppDimensions.h5(context)),
                Text(walletAdresse,
                  softWrap: true,
                  style: TextStyle(
                    color: AppColors.grisClair,
                    fontSize: 16,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: walletState ?
                    AppColors.transactionAcceptedColor.withAlpha((0.1 * 255).toInt(),)
                        :
                    AppColors.transactioRejectedColor.withAlpha((0.1 * 255).toInt(),),

                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5,),
                    child: Text(walletState ? "activé" : "désactivé",
                      style: TextStyle(
                        color: walletState ?
                        Colors.green
                            :
                        AppColors.transactioRejectedColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildWalletList(List<WalletEntity> wallets) {
    return ListView.builder(
      itemCount:  wallets.length,
      itemBuilder: (context, index) {

        WalletEntity wallet = wallets[index];

        return  Container(
            margin:  const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15,),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  walletCard(wallet.nameWallet,wallet.address,wallet.actif),
                  /* Expanded(
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          color: AppColors.grisBackgroundColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.account_balance_wallet,
                                              color: AppColors.textGrisColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(wallet.nameWallet,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: AppDimensions.h5(context)),
                                            Text(wallet.address,
                                              softWrap: true,
                                              style: TextStyle(
                                               color: AppColors.grisClair,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: wallet.actif ?
                                                AppColors.transactionAcceptedColor.withAlpha((0.1 * 255).toInt(),)
                                                    :
                                                AppColors.transactioRejectedColor.withAlpha((0.1 * 255).toInt(),),

                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5,),
                                                child: Text(wallet.actif ? "activé" : "désactivé",
                                                  style: TextStyle(
                                                    color: wallet.actif ?
                                                    Colors.green
                                                        :
                                                    AppColors.transactioRejectedColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                  // etat du wallet
                  // IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
                  PopupMenuButton<String>(
                    color: Colors.white,
                    onSelected: (String item) {

                      if (item == "details") {
                        Navigator.of(context).pushNamed(AppRoutesName.walletsDetailsPage,
                            arguments: {
                              "nameWallet":wallet.nameWallet,
                              "address":wallet.address,
                              "blockChainType":wallet.blockChainType,
                              "id":wallet.id
                            }
                        );
                      }
                      if (item == "desactiver") {
                        desactiverWalletBottomSheet(context,wallet.id, index,);
                      }
                      if (item == "activer") {
                        activerWalletBottomSheet(context, wallet.id, index);
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: "details",
                        child: Text('Voir les détails',
                          style: TextStyle(
                            color: AppColors.textGrisColor,
                          ),
                        ),
                      ),
                      wallet.actif ?
                      PopupMenuItem<String>(
                        value: "desactiver",
                        child: Text('Désactiver',
                          style: TextStyle(
                            color: AppColors.textGrisColor,
                          ),
                        ),
                      )
                          :
                      PopupMenuItem<String>(
                        value: "activer",
                        child: Text('Activer',
                          style: TextStyle(
                            color: AppColors.textGrisColor,
                          ),
                        ),
                        // Text('Supprimer'),
                      ),
                    ],
                  ),
                ],
              ),
          );
      },
    );
  }
  Widget _buildSkeletonList() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        itemCount: 5, // dummy skeleton items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              height: 80, // fixed height for skeleton effect
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  walletCard("","",true),
                  const Icon(Icons.menu)
                ],
              )
            ),
          );
        },
      ),
    );
  }
}