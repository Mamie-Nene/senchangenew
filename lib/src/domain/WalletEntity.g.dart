// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WalletEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletEntity _$WalletEntityFromJson(Map<String, dynamic> json) => WalletEntity(

      json['id'] as int,
      json['nameWallet'] as String,
      json['address'] as String,
      json['nameBlockchain'] as String,
      json['blockChainType'] as String,
      json['actif'] as bool
    );

Map<String, dynamic> _$WalletEntityToJson(WalletEntity instance) => <String, dynamic>{
      'id': instance.id,
      'nameWallet': instance.nameWallet,
      'address': instance.address,
      'nameBlockchain': instance.nameBlockchain,
      'blockChainType': instance.blockChainType,
      'actif': instance.actif

    };
