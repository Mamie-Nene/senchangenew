
import 'package:json_annotation/json_annotation.dart';

part 'NewTransactionEntity.g.dart';



@JsonSerializable()
class NewTransactionEntity{
////txHash
  String transaction_type, from_currency, to_currency,payment_method,status,wallet_address,phone_number,reference_code,created_at, blockchain, txid;
  double from_amount,to_amount,exchange_rate,fee_amount;


  NewTransactionEntity(//txHash //fee
          {
        required this.transaction_type,
        required this.from_currency,
        required this.to_currency,
        required this.payment_method,
        required this.status,
        required this.wallet_address,
        required this.phone_number,
        required this.reference_code,
        required this.created_at,
        required this.blockchain,
        required this.txid,
        required this.from_amount,
        required this.to_amount,
        required this.exchange_rate,
        required this.fee_amount
      });

  factory NewTransactionEntity.fromJson(Map<String, dynamic> data)=>_$NewTransactionEntityFromJson(data);
  Map<String,dynamic> toJson() => _$NewTransactionEntityToJson(this);
}


