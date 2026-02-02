import 'package:json_annotation/json_annotation.dart';

part 'WalletEntity.g.dart';

@JsonSerializable()
class WalletEntity{
  final int id;
  String nameWallet, address, nameBlockchain, blockChainType;
  bool actif;


  WalletEntity(
      this.id,
      this.nameWallet,
      this.address,
      this.nameBlockchain,
      this.blockChainType,
      this.actif
      );

  factory WalletEntity.fromJson(Map<String, dynamic> data)=>_$WalletEntityFromJson(data);
  Map<String,dynamic> toJson() => _$WalletEntityToJson(this);
}