// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CurrencyExchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyExchange _$CurrencyExchangeFromJson(Map<String, dynamic> json) => CurrencyExchange(

      json['id'] as String,
      json['from_currency'] as String,
      json['to_currency'] as String,
       json['rate'] as double,
      json['spread_percentage'] as double,
       json['updated_at'] as String,
       json['is_active'] as bool,

    );

Map<String, dynamic> _$CurrencyExchangeToJson(CurrencyExchange instance) => <String, dynamic>{


    };
