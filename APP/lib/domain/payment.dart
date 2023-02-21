import 'user.dart';

class Payment {
  User fromUser;
  User toUser;
  double amount = 0.0;

  Payment(this.fromUser, this.toUser, this.amount);

  factory Payment.fromJson(dynamic json) {
    User fromUser = User.fromJson(json["from_user"]);
    User toUser = User.fromJson(json["to_user"]);
    return Payment(fromUser, toUser, json["amount"] as double);
  }

  @override
  String toString() {
    String fromName = fromUser.name;
    String toName = toUser.name;
    double rounded = double.parse((amount).toStringAsFixed(2));
    return "$fromName -> $toName: \$$rounded";
  }
}