import 'dart:convert';
import '../domain/domain.dart';

List<User> users = [];
List<Payment> payments = [];
List<Expense> expenses = [];

void decodeUsers(String data) {
  var tagsJson = jsonDecode(jsonDecode(data)['users']) as List;
  users =
      tagsJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
}

void decodePayments(String data) {
  var tagsJson = jsonDecode(jsonDecode(data)['payments']) as List;
  payments =
      tagsJson.map((payJson) => Payment.fromJson(jsonDecode(payJson))).toList();
}

void decodeExpenses(String data) {
  var tagsJson = jsonDecode(jsonDecode(data)['expenses']) as List;
  expenses =
      tagsJson.map((expJson) => Expense.fromJson(jsonDecode(expJson))).toList();
}

String listToString(List<Object> list) {
  String output = "";
  for (var obj in list) {
    output += "$obj\n";
  }
  return output;
}

User getUserByID(int id) {
  return users.firstWhere((u) => u.id == id);
}
