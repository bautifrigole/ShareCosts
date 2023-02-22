import 'domain.dart';

class Expense {
  String description;
  User payerUser;
  double amount = 0.0;

  Expense(this.description, this.payerUser, this.amount);

  factory Expense.fromJson(dynamic json) {
    User toUser = User.fromJson(json["payer_user"]);
    var amount = json["amount"] ?? 0;
    return Expense(json["description"] as String, toUser, amount.toDouble());
  }

  @override
  String toString() {
    String name = payerUser.name;
    double rounded = double.parse((amount).toStringAsFixed(2));
    return "$description (\$$rounded): $name";
  }
}