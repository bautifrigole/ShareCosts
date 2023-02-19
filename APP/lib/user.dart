class User {
  int id = 0;
  String name = "";
  double spentMoney = 0.0;

  User(this.id, this.name, this.spentMoney);

  factory User.fromJson(dynamic json){
    double money = json["spent_money"] ?? 0;
    return User(json["id"] as int, json["name"] as String, money);
  }

  @override
  String toString() {
    return '{ $id, $name, $spentMoney }';
  }
}