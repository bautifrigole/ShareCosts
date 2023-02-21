class User {
  int id = 0;
  String name = "";
  double balance = 0.0;

  User(this.id, this.name, this.balance);

  factory User.fromJson(dynamic json){
    var money = json["balance"] ?? 0;
    return User(json["id"] as int, json["name"] as String, money.toDouble());
  }

  @override
  String toString() {
    return '$name: $balance';
  }
}