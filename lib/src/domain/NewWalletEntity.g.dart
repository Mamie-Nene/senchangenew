// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewWalletEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewWalletEntity _$NewWalletEntityFromJson(Map<String, dynamic> json) => NewWalletEntity(

      json['id'] as String,
      json['user_id'] as String,
      json['label'] as String,
      json['address'] as String,
      json['blockchain'] as String,
      json['currency'] as String,
      json['is_default'] as bool
    );

Map<String, dynamic> _$NewWalletEntityToJson(NewWalletEntity instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'label': instance.label,
      'address': instance.address,
      'blockchain': instance.blockchain,
      'currency': instance.currency,
      'is_default': instance.is_default

    };
