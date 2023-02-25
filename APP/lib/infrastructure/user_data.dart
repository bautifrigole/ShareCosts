import 'dart:convert';
import '../domain/domain.dart';
import 'server.dart';

List<User> users = [];
List<Payment> payments = [];
List<Expense> expenses = [];

Future<void> updateInfo() async {
  var url = ip + infoKey;
  String data = await fetchData(url);
  decodeUsers(data);
  decodeExpenses(data);
  decodePayments(data);
}

Future<void> clearInfo() async {
  var url = ip + clearKey;
  fetchData(url);
  users.clear();
  expenses.clear();
  payments.clear();
}

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

String listToString(List<Object> list) {
  String output = "";
  for (var obj in list) {
    output += "$obj\n";
  }
  return output;
}

User getUserByID(int id){
  return users.firstWhere((u) => u.id == id);
}