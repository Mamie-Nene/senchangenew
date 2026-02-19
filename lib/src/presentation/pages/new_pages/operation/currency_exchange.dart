import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatelessWidget {
  const CurrencyConverterPage({super.key});

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
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Column(
            children: [
              /// Title
              Column(
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
                  const SizedBox(height: 8),
                  Text(
                    'Convertissez vos devises avec les meilleurs taux',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

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
                                  color: theme.colorScheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Convertir',
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          TextButton.icon(
                            onPressed: () {},
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
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(child: _CurrencyInput(label: 'De')),
                              const SizedBox(width: 12),

                              /// Swap
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.swap_horiz,
                                      color: theme.colorScheme.primary),
                                  style: IconButton.styleFrom(
                                    shape: const CircleBorder(),
                                    side: BorderSide(
                                      color: theme.colorScheme.primary
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),
                              Expanded(child: _CurrencyOutput(label: 'Vers')),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// Rate Box
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceVariant
                                  .withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12),
                              border:
                              Border.all(color: theme.dividerColor),
                            ),
                            child: Column(
                              children: [
                                _RateRow(
                                  label: 'Taux de change',
                                  value: '1 USD = 554,39 XOF',
                                ),
                                const SizedBox(height: 8),
                                _RateRow(
                                  label: 'Frais de service',
                                  value: '1.0%',
                                  muted: true,
                                ),
                                const Divider(height: 24),
                                _RateRow(
                                  label: 'Dernière mise à jour',
                                  value: '14:46:43',
                                  small: true,
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

              const SizedBox(height: 32),

              /// Available rates
              Text(
                'Taux disponibles',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.8,
                children: const [
                  _RateTile('🇸🇳 XOF', '💵 USDT', '1 = 0,002'),
                  _RateTile('🇸🇳 XOF', '🇺🇸 USD', '1 = 0,002'),
                  _RateTile('🇺🇸 USD', '🇸🇳 XOF', '1 = 554,39', selected: true),
                  _RateTile('💵 USDT', '🇸🇳 XOF', '1 = 554,3'),
                  _RateTile('💲 USDC', '🇸🇳 XOF', '1 = 554,3'),
                  _RateTile('🇸🇳 XOF', '💲 USDC', '1 = 0,002'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _CurrencyInput extends StatelessWidget {
  final String label;
  const _CurrencyInput({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: Colors.grey)),
        const SizedBox(height: 6),
        _CurrencySelector(),
        const SizedBox(height: 6),
        TextField(
          keyboardType: TextInputType.number,
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            hintText: '0.00',
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencyOutput extends StatelessWidget {
  final String label;
  const _CurrencyOutput({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: Colors.grey)),
        const SizedBox(height: 6),
        _CurrencySelector(),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
          decoration: const InputDecoration(
            hintText: '0.00',
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).dividerColor),
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Row(
            children: [
              Text('🇺🇸'),
              SizedBox(width: 8),
              Text('USD'),
            ],
          ),
          Icon(Icons.expand_more, size: 18),
        ],
      ),
    );
  }
}

class _RateRow extends StatelessWidget {
  final String label;
  final String value;
  final bool muted;
  final bool small;

  const _RateRow({
    required this.label,
    required this.value,
    this.muted = false,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: muted
                  ? Colors.grey
                  : theme.colorScheme.onBackground.withOpacity(0.7),
            )),
        Text(value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
            )),
      ],
    );
  }
}

class _RateTile extends StatelessWidget {
  final String from;
  final String to;
  final String rate;
  final bool selected;

  const _RateTile(this.from, this.to, this.rate,
      {this.selected = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selected
            ? theme.colorScheme.primary.withOpacity(0.1)
            : theme.cardColor,
        border: Border.all(
          color: selected
              ? theme.colorScheme.primary
              : theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$from → $to',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(rate,
              style: theme.textTheme.bodySmall
                  ?.copyWith(fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
