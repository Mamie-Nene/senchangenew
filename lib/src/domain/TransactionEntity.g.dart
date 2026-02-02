// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransactionEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionEntity _$TransactionEntityFromJson(Map<String, dynamic> json) => TransactionEntity(

    json['addressWallet']??"Aucun",
    json['walletName']??"Aucun",
    json['blockchainName']??"Aucun",
    json['transactionId'] as String,
    json['dateTransaction'] as String,
    json['typeTransaction'] as String,
    json['statusTransaction'] as String,
    //  json['username'] as String,
   //   json['userFullName'] as String,
    json['amountInit'] ??0.0,
      json['amountChange'] ??0.0,
      json['addressOwner']??"Aucun",
      json['phoneNumber'] ??"Aucun",
      json['operator'] ??"Aucun"
    );

Map<String, dynamic> _$TransactionEntityToJson(TransactionEntity instance) => <String, dynamic>{
      'addressWallet': instance.addressWallet,
      //'addressOwner': instance.addressOwner,
      //'phoneNumber': instance.phoneNumber,
      //'operator': instance.operator,

      'amountInit': instance.amountInit,

    };
