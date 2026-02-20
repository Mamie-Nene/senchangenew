import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/src/data/local/operation_card_data.dart';

import '/src/data/remote/currency_exchange.dart';
import '/src/domain/CurrencyExchange.dart';
import '/src/utils/consts/app_specifications/allDirectories.dart';



class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  List<CurrencyExchange> currency = [];
  bool isLoading = true;

  bool isSelected=true;
 TextEditingController inputController = TextEditingController();
 TextEditingController outputController = TextEditingController();

 int indexChangeSelected = 0;

  List<CurrencyPair> pairs = [];

   CurrencyPair? selectedPair;

  String selectedFrom = "USD";
  String selectedTo = "XOF";
  String selectedFromFlag = "🇺🇸";
  String selectedToFlag = "🇸🇳";
  String rateFrom = "1";
  String rateTo = "554,39";


  /*getListCurrency(BuildContext context,) async {
    await CurrencyExchangeApi().getListCurrency(context).then((value) {
      setState(() {
        currency = value;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });
    });
  }
*/
  getListCurrency(BuildContext context) async {
     await CurrencyExchangeApi().getListCurrency(context).then(
        (value){
          setState(() {
            isLoading = false;
            pairs = value
                .where((e) => e.is_active == true)
                .map((e) => CurrencyPair(
              fromCode: e.from_currency,
              toCode: e.to_currency,
              rate: e.rate,
              spread: e.spread_percentage,
              updatedAt: DateTime.parse(e.updated_at),
            )
            ).toList();

            selectedPair = pairs.first;

            _applySelectedPair();

          });

        }).onError((error, stackTrace) {
          setState(() {isLoading = false;});
        });
  }

  void _applySelectedPair() {
    selectedFrom = selectedPair!.fromCode;
    selectedTo = selectedPair!.toCode;
    selectedFromFlag = selectedPair!.fromFlag;
    selectedToFlag = selectedPair!.toFlag;

    _convert();
  }

  void _convert() {
    final input = double.tryParse(inputController.text);
    if (input == null) {
      outputController.text = "";
      return;
    }

    final result = input * selectedPair!.rate;
    outputController.text = result.toStringAsFixed(2);
  }

  @override
  void initState() {

  getListCurrency(context);

  inputController.addListener(_convert);

  indexChangeSelected= 0;
  /*pairs = [
    CurrencyPair(fromFlag: "🇸🇳", fromCode: "XOF", toFlag: "💲", toCode: "USDC", rate: "1 = 0,002 "),
    CurrencyPair(fromFlag: "🇸🇳", fromCode: "XOF", toFlag: "🇺🇸", toCode: "USD", rate: "1 = 0,002 "),
    CurrencyPair(fromFlag: "🇸🇳", fromCode: "XOF", toFlag: "💵", toCode: "USDT", rate: "1 = 0,002 "),
    CurrencyPair(fromFlag: "💲", fromCode: "USDC", toFlag: "🇸🇳", toCode: "XOF",rate: "1 = 553,29"),
    CurrencyPair(fromFlag: "💵", fromCode: "USDT", toFlag: "🇸🇳", toCode: "XOF", rate: "1 =  553,29"),
    CurrencyPair(fromFlag: "🇺🇸", fromCode: "USD", toFlag: "🇸🇳", toCode: "XOF", rate: "1 = 554.39"),

  ];

  selectedPair = pairs[1];

  selectedFrom = selectedPair.fromCode;
  selectedTo = selectedPair.toCode;
  selectedFromFlag = selectedPair.fromFlag;
  selectedToFlag = selectedPair.toFlag;
  rateFrom = selectedPair.rate.substring(0,2);

  rateTo = selectedPair.rate.substring(4,10);
*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Échange",
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
          padding: const EdgeInsets.fromLTRB(16, 5, 16, 32),
          child: Column(
            spacing: 16,
            children: [
              RichText(
                    text: TextSpan(
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                      children: [
                        const TextSpan(text: 'Convertisseur de '),
                        TextSpan(
                          text: 'Devises',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
              Text(
                'Convertissez vos devises avec les meilleurs taux',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
              isLoading?
              const Center(child: CircularProgressIndicator())
                  :
              pairs.isEmpty?
              const Center(child: Text("Pas de données"))
                  :
              Column(
                spacing: 16,
                  children: [
                    /// Converter Card
                    Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.dividerColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          /// Card Header
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.trending_up,
                                        color: AppColors.secondAppColor),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Convertir',
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                TextButton.icon(
                                  onPressed: ()async {
                                    setState(() => isLoading = true);
                                    await getListCurrency(context);
                                  },
                                  /* onPressed: () {
                              setState(() {
                                indexChangeSelected=0;
                                selectedFrom = selectedPair.fromCode;
                                selectedTo = selectedPair.toCode;
                                selectedFromFlag = selectedPair.fromFlag;
                                selectedToFlag = selectedPair.toFlag;
                                rateFrom = selectedPair.formattedRate;
                               // rateTo = selectedPair.rate;
                              });
                              },*/
                                  icon: const Icon(Icons.refresh, size: 18),
                                  label: const Text('Actualiser'),
                                ),
                              ],
                            ),
                          ),

                          /// Inputs
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              spacing: 16,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                        child: currencyInput(context,
                                            label: 'De',
                                            inputController: inputController
                                        )
                                    ),
                                    const SizedBox(width: 12),

                                    /// Swap
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12),
                                      child: IconButton(
                                        onPressed: () {
                                          final tempCode = selectedFrom;
                                          final tempFlag = selectedFromFlag;
                                          setState(() {
                                            selectedFrom = selectedTo;
                                            selectedFromFlag = selectedToFlag;

                                            selectedTo = tempCode;
                                            selectedToFlag = tempFlag;
                                          });


                                        },
                                        icon: Icon(Icons.swap_horiz,
                                            color: AppColors.secondAppColor),
                                        style: IconButton.styleFrom(
                                          shape: const CircleBorder(),
                                          side: BorderSide(
                                            color: AppColors.secondAppColor
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 12),
                                    Expanded(child: currencyOutput(context,label: 'Vers',outputController:outputController)),
                                  ],
                                ),
                                /// Rate Box
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surfaceContainer
                                        .withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                    Border.all(color: theme.dividerColor),
                                  ),
                                  child: Column(
                                    children: [
                                      rateRow(context,
                                        label: 'Taux de change',
                                        value: selectedPair!.formattedRate,
                                        // value: '$rateFrom $selectedFrom = $rateTo $selectedTo',
                                      ),
                                      const SizedBox(height: 8),
                                      rateRow(context,
                                        label: 'Frais de service',
                                        // value: '1.0%',
                                        value: "${(selectedPair!.spread * 100).toStringAsFixed(2)}%",
                                        muted: true,
                                      ),
                                      const Divider(height: 24),
                                      rateRow(context,
                                        label: 'Dernière mise à jour',
                                        value: TimeOfDay.fromDateTime(selectedPair!.updatedAt)
                                            .format(context),
                                        small: true,
                                        //value: '14:46:43',

                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    Text(
                      'Taux disponibles',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),

                    GridView.builder(
                      itemCount: pairs.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index) {
                        final pair = pairs[index];
                        return rateTile(
                            context, pair: pair, selected: indexChangeSelected == index,
                            action :(){
                              selectedPair = pair;
                              indexChangeSelected = index;
                             setState(() {
                               _applySelectedPair();
                             });
                            }
                        );
                        /*action: (){
                        setState(() {
                          indexChangeSelected = index;
                          selectedFrom = pair.fromCode;
                          selectedFromFlag = pair.fromFlag;
                          selectedTo = pair.toCode;
                          selectedToFlag = pair.toFlag;
                          rateFrom = pair.formattedRate;
                          rateTo = pair.formattedRate;

                        });
                    });*/
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.3,
                      ),
                    ),



                  ]
              ),
            ],
          ),
        ),
      ),
    );
  }

 currencyInput(BuildContext context,{required String label,required TextEditingController inputController}) {
  final theme = Theme.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: Colors.grey)),
      const SizedBox(height: 6),
      currencySelector(context,
        flag: selectedFromFlag,
        code: selectedFrom,
        onTap: () {
         // showCurrencyBottomSheet(isFrom: true);
          },
      ),
      const SizedBox(height: 6),
      TextField(
        controller: inputController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: theme.textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: '0.00',
          filled: true,
          fillColor: theme.colorScheme.surfaceContainer
       .withOpacity(0.4),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ],
  );
 }

 currencyOutput(BuildContext context,{required String label,required TextEditingController outputController}){
  final theme = Theme.of(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: Colors.grey)),
      const SizedBox(height: 6),
      currencySelector(context,
        flag: selectedToFlag,
        code: selectedTo,
        onTap: () {
         // showCurrencyBottomSheet(isFrom: false);
        },
      ),
      const SizedBox(height: 6),
      TextField(
        controller: outputController,
        readOnly: true,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.secondAppColor,
        ),
        decoration: InputDecoration(
          hintText: '0.00',
          filled: true,
          fillColor: theme.colorScheme.surfaceContainer
              .withOpacity(0.4),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ],
  );
}

  currencySelector (BuildContext context,{
    required String flag,
    required String code,
    required VoidCallback onTap,
  }){
  return InkWell(
    onTap: onTap,
    child: Container(

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).dividerColor),
       // color: Theme.of(context).colorScheme.surfaceVariant,
        color: Theme.of(context).colorScheme.surfaceContainer,

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(flag),
              SizedBox(width: 8),
              Text(code),
            ],
          ),
          const Icon(Icons.expand_more, size: 18),
        ],
      ),
      ),
  );
  }

  rateRow (BuildContext context, {
    required String label,
    required String value,
    bool muted = false,
    bool small= false,
  }){
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: muted
          ? Colors.grey
              : theme.colorScheme.onBackground.withOpacity(0.7),
          )
        ),
        Text(value,
          style: theme.textTheme.bodySmall?.copyWith(
          fontFamily: 'monospace',
          )
        ),
      ],
    );
  }

  rateTile(BuildContext context,{
    required CurrencyPair pair,
    required bool selected,
    required VoidCallback action
  }){
    final theme = Theme.of(context);
    return InkWell(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
       // padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: selected ? theme.colorScheme.primary.withOpacity(0.1) : theme.cardColor,
         color: selected ? AppColors.secondAppColor.withOpacity(0.1) : theme.cardColor,
          border: Border.all(
            color: selected ? AppColors.secondAppColor : theme.dividerColor,
            //color: selected ? theme.colorScheme.primary : theme.dividerColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${pair.fromFlag} ${pair.fromCode} → ${pair.toFlag} ${pair.toCode}',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(pair.formattedRate,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

}

class CurrencyPair {
  final String fromCode;
  final String toCode;
  final double rate;
  final double spread;
  final DateTime updatedAt;

  CurrencyPair({
    required this.fromCode,
    required this.toCode,
    required this.rate,
    required this.spread,
    required this.updatedAt,
  });

  String get fromFlag => currencyFlags[fromCode] ?? "🏳️";
  String get toFlag => currencyFlags[toCode] ?? "🏳️";

  String get formattedRate => "1 $fromCode = ${rate.toStringAsFixed(4)} $toCode";
}
