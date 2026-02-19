import 'package:json_annotation/json_annotation.dart';

part 'NewWalletEntity.g.dart';

@JsonSerializable()
class NewWalletEntity{
  String id, user_id,label, address, blockchain, currency;
  bool is_default;

  NewWalletEntity(
      this.id,
      this.user_id,
      this.label,
      this.address,
      this.blockchain,
      this.currency,
      this.is_default
      );

  factory NewWalletEntity.fromJson(Map<String, dynamic> data)=>_$NewWalletEntityFromJson(data);
  Map<String,dynamic> toJson() => _$NewWalletEntityToJson(this);
}