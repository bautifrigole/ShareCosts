import 'package:app/user.dart';
import 'dart:convert';

class Payment {
  User fromUser;
  User toUser;
  double amount = 0.0;

  Payment(this.fromUser, this.toUser, this.amount);

  factory Payment.fromJson(dynamic json){
    // TODO: hay que ver si funciona esto
    User fromUser =  User.fromJson(jsonDecode(json["from_user"]));
    User toUser =  User.fromJson(jsonDecode(json["to_user"]));
    return Payment(fromUser, toUser, json["amount"] as double);
  }

  @override
  String toString() {
    String fromName = fromUser.name;
    String toName = toUser.name;
    return '{ $fromName must pay $amount to $toName }';
  }
}