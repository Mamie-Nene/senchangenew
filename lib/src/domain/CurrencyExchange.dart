
import 'package:json_annotation/json_annotation.dart';

part 'CurrencyExchange.g.dart';



@JsonSerializable()
class CurrencyExchange{

  String id, from_currency, to_currency,updated_at;
  double rate, spread_percentage;
  bool is_active;

  CurrencyExchange(
         this.id,
         this.from_currency,
         this.to_currency,
         this.rate,
         this.spread_percentage,
         this.updated_at,
         this.is_active
      );

  factory CurrencyExchange.fromJson(Map<String, dynamic> data)=>_$CurrencyExchangeFromJson(data);
  Map<String,dynamic> toJson() => _$CurrencyExchangeToJson(this);
}


