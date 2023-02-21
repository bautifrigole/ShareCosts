import 'dart:convert';

import '../infrastructure/function.dart';
import 'domain.dart';

class UsersGroup {
  String data = "";
  String output = "Initial output";
  List<User> users = [];
  List<Payment> payments = [];

  Future<void> addUser(String name) async {
    var url = "${ip + addUserKey}?$name";
    data = await fetchData(url);

    var tagsJson = jsonDecode(jsonDecode(data)['users']) as List;
    users = tagsJson
        .map((userJson) => User.fromJson(jsonDecode(userJson)))
        .toList();
  }

  Future<void> addExpense(String id, String spentMoney) async {
    var url = "${ip + addExpenseKey}?$id&$spentMoney";
    data = await fetchData(url);

    var tagsJson = jsonDecode(jsonDecode(data)['users']) as List;
    users = tagsJson
        .map((userJson) => User.fromJson(jsonDecode(userJson)))
        .toList();
  }

  Future<void> calculateCosts() async {
    var url = ip + calculateKey;
    data = await fetchData(url);

    var tagsJson = jsonDecode(jsonDecode(data)['reckoning']) as List;
    payments = tagsJson
        .map((payJson) => Payment.fromJson(jsonDecode(payJson)))
        .toList();
  }

  String usersToString() {
    //TODO: por cada user crear un panel donde muestre su info
    output = "";
    for (var user in users) {
      output += "$user\n";
    }
    return output;
  }

  String paymentsToString() {
    output = "";
    for (var pay in payments) {
      output += "$pay\n";
    }
    return output;
  }
}
