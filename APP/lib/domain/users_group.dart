import 'dart:convert';
import '../infrastructure/server.dart';
import 'domain.dart';

class UsersGroup {
  String output = "Initial output";
  List<User> users = [];
  List<Payment> payments = [];
  List<Expense> expenses = [];

  Future<void> addUser(String name) async {
    var url = "${ip + addUserKey}?name=$name";
    decodeUsers(await fetchData(url));
  }

  Future<void> addExpense(String id, String spentMoney) async {
    var url = "${ip + addExpenseKey}?id=$id&balance=$spentMoney&description=desc";
    String data = await fetchData(url);
    decodeUsers(data);
    decodeExpenses(data);
  }

  Future<void> calculateCosts() async {
    var url = ip + calculateKey;
    decodePayments(await fetchData(url));
  }

  void decodeUsers(String data){
    var tagsJson = jsonDecode(jsonDecode(data)['users']) as List;
    users = tagsJson
        .map((userJson) => User.fromJson(jsonDecode(userJson)))
        .toList();
  }

  void decodePayments(String data){
    var tagsJson = jsonDecode(jsonDecode(data)['payments']) as List;
    payments = tagsJson
        .map((payJson) => Payment.fromJson(jsonDecode(payJson)))
        .toList();
  }

  void decodeExpenses(String data){
    var tagsJson = jsonDecode(jsonDecode(data)['expenses']) as List;
    expenses = tagsJson
        .map((expJson) => Expense.fromJson(jsonDecode(expJson)))
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
