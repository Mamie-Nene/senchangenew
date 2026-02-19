import 'package:flutter/material.dart';
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

  TextEditingController montantCFA = TextEditingController();
  TextEditingController montantUSDT = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();


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
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Achetez des stablecoins avec votre mobile money",
                style: TextStyle(color: Color(0xFF3D2A3A),),
              ),

              const SizedBox(height: 24),

              /// Transaction type
              const Text(
                "Type de transaction",
                style: TextStyle(color: Color(0xFF3D2A3A),fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
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
                  const SizedBox(width: 12),
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

              /// Montant CFA
              _AmountField(
                hint: "0",
                label: "Montant en CFA",
                suffix: "CFA",
                highlighted: false,
                controller: montantCFA,
              ),

              const SizedBox(height: 16),

              /// Inverser
              Center(
                child: TextButton.icon(
                  style: TextButton.styleFrom(//e5e7eb
                      backgroundColor: Color(0xffECDCEC),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.swap_vert),
                  label: const Text("Inverser"),
                ),
              ),

              const SizedBox(height: 16),

              /// Montant USDT
              _AmountField(
                hint: "0.00",
                label: "Montant en USDT",
                suffix: "USDT",
                controller: montantUSDT,
                highlighted: true,
              ),

              const SizedBox(height: 8),
              const Text(
                "Limites: 10 000 - 1 500 000 CFA",
                style: TextStyle(fontSize: 12, color: Color(0xFF3D2A3A),),
              ),

              const SizedBox(height: 24),

              /// Payment method
               _label('Moyen de paiement',icon: Icons.payment),
             // const Text("Moyen de paiement", style: TextStyle(color: Color(0xFF3D2A3A),)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: PaymentMethodCard(
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
                    child: PaymentMethodCard(
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

              const SizedBox(height: 24),

              /// Phone
              _label('Numéro de téléphone',icon: Icons.phone),

              //const Text("Numéro de téléphone", style: TextStyle(color: Color(0xFF3D2A3A),)),
              const SizedBox(height: 8),
              _InputField(
                hint: "Ex: 771234567",
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
                  _NetworkChip(  title: "TRC20", subtitle: 'TRON (TRC20)', selected: selectedNetwork=="TRC20", onTap: () { onSelect("TRC20"); },),
                  _NetworkChip( title: "ERC20", subtitle: 'Etherum (ERC20)', selected: selectedNetwork=="ERC20", onTap: () { onSelect("ERC20"); },),
                  _NetworkChip(  title: "BEP20", subtitle: 'BNB (BEP20)', selected: selectedNetwork=="BEP20", onTap: () { onSelect("BEP20");  },),
                  _NetworkChip(  title:"SOL", subtitle: 'Solona', selected: selectedNetwork=="SOL", onTap: () { onSelect("SOL");  },),
                ],
              ),
//#e5e7eb
              const SizedBox(height: 16),

              const Text("Adresses enregistrées", style: TextStyle(fontWeight: FontWeight.w400)),
              const SizedBox(height: 8),

              /// Address
              _InputField(
                hint: "wallet",
               // monospace: true,
                controller:TextEditingController(text: "0x1e4dea1c6e464e620b287cbcb1372e2a6f7ae5ad") ,
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
              color: selected ? Colors.pink : Color(0xFF3D2A3A),//.shade300,
              width: 2,
            ),
            color: selected ? Colors.pink.shade50 : null,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: selected ? Colors.pink : Color(0xFF3D2A3A),//.shade200,
                child: Icon(icon, color: selected ? Colors.white : Color(0xFF3D2A3A)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF3D2A3A),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text, {IconData? icon, Color? iconColor}) {
    return Row(
      children: [
        if (icon != null) Column(
          children: [
            Icon(icon, size: 16, color: iconColor?? Color(0xFF3D2A3A),),
            const SizedBox(width: 30),
          ],
        ),

        Text(text, style: const TextStyle(color: Color(0xFF3D2A3A),fontWeight: FontWeight.bold,fontSize: 16)),
      ],
    );
  }

}



class _AmountField extends StatelessWidget {
  final String label;
  final String suffix;
  final String hint;
  final TextEditingController controller;

  const _AmountField({
    required this.label,
    required this.suffix,
    required this.hint,
    required this.controller, required bool highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
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
}

class PaymentMethodCard extends StatelessWidget {
  final String label;
  final String imageUrl;
  final bool selected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    required this.label,
    required this.imageUrl,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //,Theme.of(context).primaryColor
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ?Theme.of(context).primaryColor.withOpacity(0.1):Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: selected ? Color(0xFFF6B300) : Color(0xFF3D2A3A),
          ),
        ),
        child: Column(
          children: [
            Image.network(imageUrl, height: 40),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
class _InputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const _InputField({
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffECDCEC),
        //fillColor: Color(0xffecdcec),
        //fillColor: Color(0xffe3e2e3),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
class _NetworkChip extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _NetworkChip({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? Color(0xFFF6B300) : Color(0xFF3D2A3A),
            width: 2,
          ),
          color: selected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
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
}

class BuyUsdtButton extends StatelessWidget {
  final bool disabled;
  final VoidCallback? onPressed;

  const BuyUsdtButton({
    super.key,
    required this.disabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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

