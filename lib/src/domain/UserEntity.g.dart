// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
    json['firstName'] as String,
    json['lastName'] as String,
    json['phoneNumber'] as String,
    json['email'] as String,
    json['username'] as String,
    json['password'] as String
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
  'username': instance.username,
  'password': instance.password
};
