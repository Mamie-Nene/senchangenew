
import 'package:json_annotation/json_annotation.dart';

part 'TransactionEntity.g.dart';

@JsonSerializable()
class TransactionEntity{
  String? addressWallet,walletName, blockchainName;
  String transactionId, dateTransaction,typeTransaction;
  String statusTransaction;//,username,userFullName
  double? amountInit, amountChange;
  String?  phoneNumber , operator,addressOwner; //,

  TransactionEntity(
      this.addressWallet,
      this.walletName,
      this.blockchainName,
      this.transactionId,
      this.dateTransaction,
      this.typeTransaction,
      this.statusTransaction,
     // this.username,
   //   this.userFullName,
      this.amountInit,
     this.amountChange,
      this.addressOwner,
     this.phoneNumber,
      this.operator
      );

  factory TransactionEntity.fromJson(Map<String, dynamic> data)=>_$TransactionEntityFromJson(data);
  Map<String,dynamic> toJson() => _$TransactionEntityToJson(this);
}