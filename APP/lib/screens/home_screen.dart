import 'package:app/domain/users_group.dart';

import 'package:flutter/material.dart';

const String ip = "http://10.0.2.2:5000/";
const String addUserKey = "add_user";
const String addExpenseKey = "add_expense";
const String calculateKey = "calculate";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String id = "";
  String name = "";
  String spentMoney = "";
  String output = "";

  UsersGroup group = UsersGroup();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Calculate Costs"),
          backgroundColor: Colors.indigo
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
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
                  name = "name=$value";
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
                  id = "id=$val";
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
                  spentMoney = "balance=$val";
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
    await group.addExpense(id, spentMoney);
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
