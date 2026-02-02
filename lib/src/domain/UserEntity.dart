
import 'package:json_annotation/json_annotation.dart';

part 'UserEntity.g.dart';

@JsonSerializable()
class UserEntity{
  String firstName, lastName, phoneNumber, email, username, password;


  UserEntity(this.firstName, this.lastName, this.phoneNumber, this.email,
      this.username, this.password);


  @override
  String toString() {
    return 'UserEntity{firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, email: $email, username: $username, password: $password}';
  }

  factory UserEntity.fromJson(Map<String, dynamic> data)=>_$UserEntityFromJson(data);
  Map<String,dynamic> toJson() => _$UserEntityToJson(this);
}