
import 'package:json_annotation/json_annotation.dart';

part 'NewTransactionEntity.g.dart';

@JsonSerializable()
class NewTransactionEntity{

  String transaction_type, fromCurrency, toCurrency,payment_method,status,wallet_address,phone_number,referenceCode,created_at, blockchain;
  double from_amount,to_amount,exchange_rate,fee_amount;


  NewTransactionEntity(
      this.transaction_type,
      this.fromCurrency,
      this.toCurrency,
      this.payment_method,
      this.status,
      this.wallet_address,
      this.phone_number,
      this.referenceCode,
      this.created_at,
      this.blockchain,
      this.from_amount,
      this.to_amount,
      this.exchange_rate,
      this.fee_amount);

  factory NewTransactionEntity.fromJson(Map<String, dynamic> data)=>_$NewTransactionEntityFromJson(data);
  Map<String,dynamic> toJson() => _$NewTransactionEntityToJson(this);
}