// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewTransactionEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewTransactionEntity _$NewTransactionEntityFromJson(Map<String, dynamic> json) => NewTransactionEntity(

    json['transaction_type'] as String,
    json['fromCurrency'] as String,
    json['toCurrency'] as String,
    json['payment_method'] as String,
    json['status'] as String,
    json['wallet_address'] as String,
    json['phone_number'] as String,
    json['referenceCode'] as String,
    json['created_at'] as String,
    json['blockchain'] as String,
    json['from_amount'] as double,
    json['to_amount'] as double,
    json['exchange_rate'] as double,
    json['fee_amount'] as double,


    );

Map<String, dynamic> _$NewTransactionEntityToJson(NewTransactionEntity instance) => <String, dynamic>{


    };
