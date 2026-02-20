import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/utils/consts/constants.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/utils/consts/routes/app_routes_name.dart';
import '/src/presentation/widgets/app_utils.dart';

class AchatPageNewNew extends StatefulWidget {
  const AchatPageNewNew ({super.key});

  @override
  State<AchatPageNewNew > createState() => _AchatPageState();
}

class _AchatPageState extends State<AchatPageNewNew > {
  String selectedPayment = 'wave';
  String selectedNetwork = 'TRC20';
  String stableCoin = 'USDT';

  bool isDataInterverted=false;
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  double tauxAchat = 0.0018;

  bool isTauxVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Achat",
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Achetez des stablecoins avec votre mobile money",
                 style: TextStyle(color: AppColors.mainAppTextColor,),
              ),

              const SizedBox(height:12),

              Text(
                "Type de transaction",
                style: TextStyle(color: AppColors.mainAppTextColor,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: AppUtilsWidget().transactionTypeCard(
                      context,
                      title: "Acheter",
                      subtitle: "CFA → Crypto",
                      icon: Icons.south_west,
                      active: true,
                      activeColor: Colors.green,
                      selected: true,
                      onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutesName.acheterPage) ,
                    ),
                  ),
                  Expanded(
                    child: AppUtilsWidget().transactionTypeCard(
                      context,
                      title: "Vendre",
                      subtitle: "Crypto → CFA",
                      icon: Icons.north_east,
                      active: false,
                      selected:false,
                      onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutesName.vendrePage),
                      activeColor: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _label('Stablecoin'),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: stableCoin,
                items: const [
                  DropdownMenuItem(value: 'USDT', child: Text('💵 Tether (USDT)')),
                  DropdownMenuItem(value: 'USDC', child: Text('💲 USD Coin (USDC)')),
                ],
                onChanged: (v) => setState(() => stableCoin = v!),
                decoration: _inputDecoration(),
              ),
              const SizedBox(height: 24),

              amountField(
                hint: "0",
                label: "Montant en CFA",
                suffix: "CFA",
                highlighted: false,
                readOnlyActivated: false,
                controller: inputController,
                onTap: (){
                  setState(() {
                    isTauxVisible = true;
                    outputController.text = inputController.text * tauxAchat.toInt();
                  });
                }
              ),

              const SizedBox(height: 16),

              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(//e5e7eb
                      backgroundColor: AppColors.secondAppColor.withOpacity(0.1)
                    // backgroundColor: theme.cardColor,//Color(0xffECDCEC)
                  ),
                  onPressed: () {
                    setState(() {
                    final tempCFA = inputController.text;
                    final tempUSDT = outputController.text;
                    inputController.text = tempUSDT;
                    outputController.text = tempCFA;
                  });},
                  icon:  Icon(Icons.swap_vert,color:  AppColors.secondAppColor),
                  // label:  Text("Inverser"),
                label:  Text("Inverser",style: TextStyle(color: AppColors.secondAppColor),),
                ),
              ),

              const SizedBox(height: 16),

              /// Montant USDT
              amountField(
                hint: "0.00",
                label: "Montant en USDT",
                suffix: "USDT",
                controller: outputController,
                readOnlyActivated: true,
                highlighted: true,
                onTap: null
              ),

              const SizedBox(height: 8),
               Text(
                "Limites: 10 000 - 1 500 000 CFA",
                style: TextStyle(fontSize: 12, color: AppColors.mainAppTextColor,),
              ),

              const SizedBox(height: 24),
              Visibility(
                visible: isTauxVisible,
                child:Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer
                      .withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    rateRow(context,
                      label: 'Frais(1%)',
                      value: '1.0%',
                    //  value: "${(selectedPair!.spread * 100).toStringAsFixed(2)}%",

                    ),
                    const SizedBox(height: 8),
                    rateRow(context,
                      label: 'Frais réseau $selectedNetwork',
                     // value: selectedPair!.formattedRate,
                       value: '',
                    ),
                    const Divider(height: 24),
                    rateRow(context,
                      label: 'Total',
                      value: outputController.text,
                      small: true,
                      isTotal: true,
                      //value: '14:46:43',

                    ),
                  ],
                ),
              ),
              ),
              const SizedBox(height: 24),
              /// Payment method
               _label('Moyen de paiement',icon: Icons.payment),
             // const Text("Moyen de paiement", style: TextStyle(color: AppColors.mainAppTextColor,)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppUtilsWidget().paymentMethodCard(context,
                      label: "Wave",
                      imageUrl:Constants.waveImageLink,
                      selected: selectedPayment == 'wave',
                      onTap: () =>
                          setState(() => selectedPayment = 'wave'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child:AppUtilsWidget().paymentMethodCard(context,
                      label: "Orange Money",
                      imageUrl: Constants.omImageLink,
                      selected: selectedPayment == 'orange',
                      onTap: () =>
                          setState(() => selectedPayment = 'orange'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Phone
              _label('Numéro de téléphone',icon: Icons.phone),

              //const Text("Numéro de téléphone", style: TextStyle(color: AppColors.mainAppTextColor,)),
              const SizedBox(height: 8),
              inputField(
                hint: "Ex: 770000000",
                keyboardType: TextInputType.phone, controller:phoneNumber,
              ),

              const SizedBox(height: 24),

              /// Network
              _label('Réseau de réception',icon: Icons.account_balance_wallet_outlined,iconColor:Color(0xFFF6B300) ),

              //const Text("Réseau de réception", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 17),
              const Text("Sélectionner le réseau *", style: TextStyle(fontWeight: FontWeight.w400)),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [//selectedNetwork
                  networkChip(  title: "TRC20", subtitle: 'TRON (TRC20)', selected: selectedNetwork=="TRC20", onTap: () { onSelect("TRC20"); },),
                  networkChip( title: "ERC20", subtitle: 'Etherum (ERC20)', selected: selectedNetwork=="ERC20", onTap: () { onSelect("ERC20"); },),
                  networkChip(  title: "BEP20", subtitle: 'BNB (BEP20)', selected: selectedNetwork=="BEP20", onTap: () { onSelect("BEP20");  },),
                  networkChip(  title:"SOL", subtitle: 'Solona', selected: selectedNetwork=="SOL", onTap: () { onSelect("SOL");  },),
                ],
              ),
//#e5e7eb
              const SizedBox(height: 16),

              const Text("Adresses enregistrées", style: TextStyle(fontWeight: FontWeight.w400)),
              const SizedBox(height: 8),

              /// Address
              inputField(
                hint: "wallet",
               // monospace: true,
                controller:TextEditingController(text: "0x1e4dea1c6e464e620b287cbcb1372e2a6f7ae5ad"),
                keyboardType: null ,
              ),

              const SizedBox(height: 16),

              /// Warning
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Row(
                  children: [
                    Icon(Icons.shield, color: Colors.orange, size: 18),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Assurez-vous que l'adresse est compatible avec $selectedNetwork",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

             /* /// Submit
              _PrimaryButton(
                text: "Acheter USDT",
                icon: Icons.south_west,
                gradient: const LinearGradient(
                  colors: [Colors.green, Colors.teal],
                ),
              ),*/

              BuyUsdtButton(
                disabled: false,
                onPressed: () {
                  // Submit / Buy logic
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  rateRow (BuildContext context, {
    required String label,
    required String value,
    bool isTotal = false,
    bool small= false,
  }){
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight:  isTotal?FontWeight.bold:null,
              color:theme.colorScheme.onBackground.withOpacity(0.7),
            )
        ),
        Text(value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight:  isTotal?FontWeight.bold:null,
              fontFamily: 'monospace',
            )
        ),
      ],
    );
  }
  InputDecoration _inputDecoration({String? hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffix,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
  void onSelect(String value) {
    setState(() => selectedNetwork = value);
  }


  Widget _label(String text, {IconData? icon, Color? iconColor}) {
    return Row(
      children: [
        if (icon != null) Column(
          children: [
            Icon(icon, size: 16, color: iconColor?? AppColors.mainAppTextColor,),
            const SizedBox(width: 30),
          ],
        ),

        Text(text, style:  TextStyle(color: AppColors.mainAppTextColor,fontWeight: FontWeight.bold,fontSize: 16)),
      ],
    );
  }

  amountField  ({
    required String label,
    required String suffix,
    required bool readOnlyActivated,
    required String hint,
    required TextEditingController controller,
    required bool highlighted,
    required VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 6),
        TextFormField(
          onTap: onTap,
          readOnly: readOnlyActivated,
          controller: controller,
          keyboardType: TextInputType.number,
          //inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
          inputFormatters:[FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez remplir ce champs';
            }
            return null;
          },
          decoration: InputDecoration(
            hint: Text(hint),
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
 }

   inputField  ({
    required String hint,
    required TextEditingController controller,
    required TextInputType? keyboardType,
  }) {
    return TextFormField(

      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez remplir ce champs';
        }
        return null;
      },
      decoration: InputDecoration(
       // filled: true,
       // fillColor: Theme.of(context).cardColor,
        //fillColor: Color(0xffECDCEC),
        //fillColor: Color(0xffe3e2e3),
        hintText: hint,
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }

   networkChip ({
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
   }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.secondAppColor : Theme.of(context).dividerColor,
            width: 2,
          ),
          color: selected
          ? AppColors.secondAppColor.withOpacity(0.1)
              : Colors.white,
          ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      );
    }

   BuyUsdtButton  ({
  required bool disabled,
  required VoidCallback? onPressed,
  }) {
  /*
    * SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );*/
    return SizedBox(
    width: double.infinity,
    height: 64,
    child: Opacity(
    opacity: disabled ? 0.5 : 1,
    child: ElevatedButton(
    onPressed: disabled ? null : onPressed,
    style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    elevation: 0,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    ),
    ).copyWith(
    backgroundColor: MaterialStateProperty.resolveWith(
    (_) => Colors.transparent,
    ),
    ),
    child: Ink(
    decoration: BoxDecoration(
    gradient: const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
    Color(0xFF22C55E), // green-500
    Color(0xFF059669), // emerald-600
    ],
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
    BoxShadow(
    color: const Color(0xFF22C55E).withOpacity(0.3),
    blurRadius: 16,
    offset: const Offset(0, 8),
    ),
    ],
    ),
    child: Container(
    alignment: Alignment.center,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
    Icon(
    Icons.south_west,
    size: 20,
    color: Colors.white,
    ),
    SizedBox(width: 8),
    Text(
    "Acheter USDT",
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    ),
    ),
    SizedBox(width: 8),
    Icon(
    Icons.arrow_forward_rounded,
    size: 20,
    color: Colors.white,
    ),
    ],
    ),
    ),
    ),
    ),
    ),
    );
  }

}



