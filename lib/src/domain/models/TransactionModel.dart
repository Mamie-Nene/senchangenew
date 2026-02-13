class TransactionModel {
  final String id;
  final String type; // ACHAT | VENTE
  final String amount;
  //final double amount;
  //final String currency;
  final String status; // acceptée | rejetée
  final String date;
 // final DateTime date;
  final String paymentMethod;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
  //  required this.currency,
    required this.status,
    required this.date,
    required this.paymentMethod,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: json['type'],
      amount: json['amount'],
     // currency: json['currency'],
      status: json['status'],
      date: json['date'],
     // date: DateTime.parse(json['date']),
      paymentMethod: json['paymentMethod'],
    );
  }
}
