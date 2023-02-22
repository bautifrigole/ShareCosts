import 'package:http/http.dart' as http;

const String ip = "http://10.0.2.2:5000/";
const String addUserKey = "add_user";
const String addExpenseKey = "add_expense";
const String calculateKey = "calculate";

fetchData(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}
