// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewTransactionEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTransactionEntity _$NewTransactionEntityFromJson(Map<String, dynamic> json) => NewTransactionEntity(

     transaction_type: json['transaction_type'] as String,
    from_currency: json['fromCurrency'] as String,
    to_currency: json['toCurrency'] as String,
      payment_method : json['payment_method'] as String,
      status : json['status'] as String,
      wallet_address : json['wallet_address'] as String,
      phone_number : json['phone_number'] as String,
      reference_code : json['referenceCode'] as String,
       created_at: json['created_at'] as String,
       blockchain : json['blockchain'] as String,
  txid : json['txid'] as String,
       from_amount : json['from_amount']?? 00.00 ,
      to_amount : json['to_amount']?? 00.00 ,
       exchange_rate : json['exchange_rate']?? 0.0018,
        fee_amount : json['fee_amount'] ?? 00.00,


    );

Map<String, dynamic> _$NewTransactionEntityToJson(NewTransactionEntity instance) => <String, dynamic>{


    };
