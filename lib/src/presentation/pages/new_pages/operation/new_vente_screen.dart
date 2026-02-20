import 'package:flutter/material.dart';
import 'package:senchange/src/utils/consts/app_specifications/allDirectories.dart';
import '/src/presentation/widgets/app_utils.dart';

import '/src/utils/consts/routes/app_routes_name.dart';

class SellUsdtScreen extends StatefulWidget {
  const SellUsdtScreen({super.key});

  @override
  State<SellUsdtScreen> createState() => _SellUsdtScreenState();
}

class _SellUsdtScreenState extends State<SellUsdtScreen> {
  String transactionType = 'sell';
  String stableCoin = 'USDT';
  String paymentMethod = 'wave';
  String network = 'SOL';
  String selectedPayment = 'wave';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:  Text(
          "Vente",
          style: TextStyle(
            color: AppColors.mainAppTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        iconTheme:  IconThemeData(color: AppColors.mainAppTextColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Vendez vos stablecoins et recevez le montant sur votre mobile money',
                  style: TextStyle(color: AppColors.mainAppTextColor,),
                ),
                const SizedBox(height:12),

                /// TRANSACTION TYPE
                _label('Type de transaction'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _transactionButton(
                      icon: Icons.call_received,
                      title: 'Acheter',
                      subtitle: 'CFA → Crypto',
                      selected: transactionType == 'buy',
                      onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutesName.acheterPage) ,
                      //onTap: () => setState(() => transactionType = 'buy'),
                    ),
                    const SizedBox(width: 12),
                    _transactionButton(
                      icon: Icons.call_made,
                      title: 'Vendre',
                      subtitle: 'Crypto → CFA',
                      selected: transactionType == 'sell',
                      onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutesName.vendrePage)
                     // onTap: () => setState(() => transactionType = 'sell'),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// STABLECOIN
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

                /// AMOUNT
                _label('Montant en USDT'),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration(
                    hint: '0.00',

                    suffix: const Text('USDT'),
                  ),
                ),
                const SizedBox(height: 4),
               Text(
                  'Montant minimum: 30 - Montant maximum: 1 500 000 USDT',
                  style: TextStyle(fontSize: 12, color: AppColors.mainAppTextColor,),
                ),

                const SizedBox(height: 24),

                /// PAYMENT METHOD
                _label('Moyen de paiement', icon: Icons.credit_card),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: AppUtilsWidget().paymentMethodCard(context,
                        label: "Wave",
                        imageUrl:
                        "https://xakfjbfsigtjibefcpgc.supabase.co/storage/v1/object/public/payment-logos/logos/59075c4f-9488-49fc-98c0-74cd58a3ee1d.png",
                        selected: selectedPayment == 'wave',
                        onTap: () =>
                            setState(() => selectedPayment = 'wave'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppUtilsWidget().paymentMethodCard(context,
                        label: "Orange Money",
                        imageUrl:
                        "https://xakfjbfsigtjibefcpgc.supabase.co/storage/v1/object/public/payment-logos/logos/5dc4224f-07f8-4888-bb18-d8a43f452fe5.png",
                        selected: selectedPayment == 'orange',
                        onTap: () =>
                            setState(() => selectedPayment = 'orange'),
                      ),
                    ),
                  ],
                ),
               /* Row(
                  children: [
                    _paymentCard('Wave', 'assets/wave.png', 'wave'),
                    const SizedBox(width: 12),
                    _paymentCard('Orange Money', 'assets/orange.png', 'orange'),
                  ],
                ),*/

                const SizedBox(height: 24),

                /// PHONE
                _label('Numéro de téléphone', icon: Icons.phone),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: _inputDecoration(hint: 'Ex: 771234567'),
                ),

                const SizedBox(height: 24),

                /// NETWORK
                _label('Sélectionner le réseau', icon: Icons.account_balance_wallet_outlined,iconColor:Color(0xFFF6B300),),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.9,
                  //childAspectRatio: 1.2,
                  children: [
                    _networkButton('SOL', 'Solana'),
                    _networkButton('TRC20', 'TRON'),
                    _networkButton('BEP20', 'BNB'),
                  ],
                ),

                const SizedBox(height: 24),

               /* /// SUBMIT
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.call_made),
                    label: const Text(
                      'Vendre USDT',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),*/

                SellUsdtButton(
                  disabled: false,
                  onPressed: () {
                    // Sell logic
                  },
                ),

              ],
            ),
        ),
      ),
    );
  }

  /// ================= HELPERS =================

  Widget _label(String text, {IconData? icon, Color? iconColor}) {
    return Row(
      children: [
        if (icon != null) Column(
          children: [
            Icon(icon, size: 16, color: iconColor?? AppColors.mainAppTextColor,),
            const SizedBox(width: 30),
          ],
        ),

        Text(text, style: TextStyle(color: AppColors.mainAppTextColor,fontWeight: FontWeight.bold)),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      suffixIcon: suffix,
        // fillColor: Color(0xffECDCEC),//Colors.pink.shade50

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );

  }

  Widget _transactionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? Colors.pink : Colors.grey.shade300,
              width: 2,
            ),
            color: selected ? Colors.pink.shade50 : null,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: selected ? Colors.pink : Colors.grey.shade200,
                child: Icon(icon, color: selected ? Colors.white : Colors.grey),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style:  TextStyle(fontSize: 12, color: AppColors.mainAppTextColor,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentCard(String title, String asset, String value) {
    final selected = paymentMethod == value;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => paymentMethod = value),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? Colors.pink : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Image.asset(asset, height: 40),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _networkButton(String code, String name) {
    final selected = network == code;
    return InkWell(
      onTap: () => setState(() => network = code),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppColors.secondAppColor : Colors.grey.shade300,
            width: 2,
          ),
          color: selected ? AppColors.secondAppColor.withOpacity(0.1) : null,
          //color: selected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(name, style: TextStyle(fontSize: 12, color: AppColors.mainAppTextColor,)),
          ],
        ),
      ),
    );
  }
}class SellUsdtButton extends StatelessWidget {
  final bool disabled;
  final VoidCallback? onPressed;

  const SellUsdtButton({
    super.key,
    required this.disabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
            backgroundColor:
            MaterialStateProperty.resolveWith((_) => Colors.transparent),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFEC4899), // pink-500
                  Color(0xFFE11D48), // rose-600
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFEC4899).withOpacity(0.3),
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
                      Icons.call_made,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Vendre USDT",
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
