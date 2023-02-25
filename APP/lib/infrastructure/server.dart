import 'package:http/http.dart' as http;
import 'user_data.dart';

//const String ip = "http://bautifrigole.pythonanywhere.com/";
const String ip = "http://10.0.2.2:5000/";
const String addUserKey = "add_user";
const String addExpenseKey = "add_expense";
const String calculateKey = "calculate";
const String infoKey = "info";
const String clearKey = "clear_info";
const String clearBalancesKey = "clear_balances";

fetchData(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

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

Future<void> addExpense(
    String id, String spentMoney, String expenseDesc) async {
  var url =
      "${ip + addExpenseKey}?id=$id&amount=$spentMoney&description=$expenseDesc";
  String data = await fetchData(url);
  decodeUsers(data);
  decodeExpenses(data);
}

Future<void> calculateCosts() async {
  var url = ip + calculateKey;
  decodePayments(await fetchData(url));
}

Future<void> clearBalances() async {
  var url = ip + clearBalancesKey;
  decodeUsers(await fetchData(url));
}
