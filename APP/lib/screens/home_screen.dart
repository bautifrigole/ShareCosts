import 'package:app/app_alerts.dart';
import 'package:app/domain/domain.dart';
import 'package:app/themes/app_theme.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int id = 0;
  String name = "";
  int spentMoney = 0;
  String output = "";

  UsersGroup group = UsersGroup();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Calculate Costs"),
          backgroundColor: AppTheme.primary),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: const Icon(
              Icons.add_card,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => AppAlerts.displayDialogAndroid(context,
                const Text("Expense"), AppAlerts.expenseInput(), addExpense),
          ),
          ElevatedButton(
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Calculate",
                style: TextStyle(fontSize: 20),
              ),
            ),
            onPressed: () {},
          ),
          FloatingActionButton(
            child: const Icon(
              Icons.person_add,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => AppAlerts.displayDialogAndroid(context,
                const Text("New User"), AppAlerts.nameInput(), addUser),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Name: ",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              TextField(
                onChanged: (value) {
                  name = value;
                },
              ),
              TextButton(
                  onPressed: addUser,
                  child: const Text(
                    "Add person",
                    style: TextStyle(fontSize: 30),
                  )),
              const Divider(height: 20),
              const Text(
                "ID: ",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              TextField(
                onChanged: (value) {
                  var val = int.tryParse(value);
                  if (val == null) return;
                  id = val;
                },
              ),
              const Divider(color: Colors.white, height: 20),
              const Text(
                "Money: ",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              TextField(
                onChanged: (value) {
                  var val = int.tryParse(value);
                  if (val == null) return;
                  spentMoney = val;
                },
              ),
              TextButton(
                  onPressed: addExpense,
                  child: const Text(
                    "Add money",
                    style: TextStyle(fontSize: 30),
                  )),
              const Divider(height: 20),
              Text(
                output,
                style: const TextStyle(fontSize: 40, color: Colors.cyan),
              ),
              TextButton(
                  onPressed: calculateCosts,
                  child: const Text(
                    "Calculate",
                    style: TextStyle(fontSize: 30),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    await group.addUser(name);
    setState(() {
      output = group.usersToString();
    });
  }

  Future<void> addExpense() async {
    await group.addExpense(id.toString(), spentMoney.toString());
    setState(() {
      output = group.usersToString();
    });
  }

  Future<void> calculateCosts() async {
    await group.calculateCosts();
    setState(() {
      output = group.paymentsToString();
    });
  }
}
