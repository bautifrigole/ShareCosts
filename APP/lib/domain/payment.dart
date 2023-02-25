import 'package:app/infrastructure/user_data.dart';

class Payment {
  int fromUserID;
  int toUserID;
  double amount = 0.0;

  Payment(this.fromUserID, this.toUserID, this.amount);

  factory Payment.fromJson(dynamic json) {
    return Payment(json["from_user_id"] as int,
        json["to_user_id"] as int, json["amount"] as double);
  }

  @override
  String toString() {
    String fromName = getUserByID(fromUserID).name;
    String toName = getUserByID(toUserID).name;
    double rounded = double.parse((amount).toStringAsFixed(2));
    return "$fromName -> $toName: \$$rounded";
  }
}
