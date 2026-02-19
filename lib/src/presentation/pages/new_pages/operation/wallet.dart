import 'package:flutter/material.dart';
import 'package:senchange/src/data/local/blockchain_type_data.dart';
import '/src/domain/NewWalletEntity.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';

class GestionWallet extends StatelessWidget {
  const GestionWallet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    NewWalletEntity walletEntity = BlockchainTypeData().walletEntity;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Portefeuilles & Adresses",
            style: TextStyle(
              color: Color(0xFF3D2A3A),
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color(0xFF3D2A3A)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Connectez vos adresses crypto pour recevoir et envoyer des paiements en toute sécurité."),
                   SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 adresse enregistrée',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed:  () {Navigator.of(context).pushNamed( AppRoutesName.addWalletPage);},
                          icon: Icon(Icons.add, size: 18,color: AppColors.mainAppColor,),
                          label:  Text('Ajouter',style: TextStyle(color: AppColors.mainAppColor,),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondAppColor ,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                   ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      /*gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.25,
                      ),*/
                      itemBuilder: (context, index) {
                        return  walletCard(context,
                          walletEntity: walletEntity
                        );

                      },
                    ),
                  ],
                ),
            ),
        ),

    );
  }
  walletCard(BuildContext context,{
  required NewWalletEntity walletEntity,
}){
    final theme = Theme.of(context);
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
        walletEntity.is_default?
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Text(
              'Par défaut',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
            :
            SizedBox.shrink(),
          Row(
            spacing: 12,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                      color: AppColors.secondAppColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                child: Icon(Icons.account_balance_wallet, color: AppColors.secondAppColor , size: 20,),
              ),
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(walletEntity.label,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _chip(context, label: walletEntity.currency, filled: true),
                          const SizedBox(width: 6),
                          _chip(context,label: walletEntity.blockchain),
                        ],
                      ),

                    ],
                  ),
            ],
          ),

          const SizedBox(height: 16),

          /// Address
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adresse',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  walletEntity.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          /// Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.copy, size: 16),
                  label: const Text('Copier'),
                ),
              ),
              const SizedBox(width: 8),
             _iconAction(context,
                icon: Icons.edit,
                onTap: () {},
              ),
              const SizedBox(width: 8),
             _iconAction(context,
                icon: Icons.delete,
                onTap: () {},
                danger: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
  _iconAction(BuildContext context,{
    required IconData icon,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        width: 40,
          decoration: BoxDecoration(
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(10),
          ),
        child: Icon(icon, size: 18, color: danger ? theme.colorScheme.error : theme.iconTheme.color,),
      ),
    );
  }

   _chip(BuildContext context, {required String label, bool filled = false}){

  final theme = Theme.of(context);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
    color: filled
    ? theme.colorScheme.secondary
        : Colors.transparent,
    borderRadius: BorderRadius.circular(20),
    border: filled
    ? null
        : Border.all(color: theme.dividerColor),
    ),
    child: Text(
    label,
    style: theme.textTheme.labelSmall?.copyWith(color: filled? theme.colorScheme.onSecondary : theme.colorScheme.onBackground, fontWeight: FontWeight.bold),
    ),
    );
  }

}



