import 'package:app/app_alerts.dart';
import 'package:app/users_dropdown.dart';
import 'package:app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:app/infrastructure/user_data.dart';
import '../infrastructure/server.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int id = 0;
  String name = "";
  int spentMoney = 0;
  String expenseDesc = "";
  String output = "-";

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
          //Clean users
          FloatingActionButton(
            onPressed: () {
              clearInfo();
              setState(() {
                output = listToString(users);
              });
            },
            child: const Icon(
              Icons.clear_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),

          //Add expense
          FloatingActionButton(
            child: const Icon(
              Icons.add_card,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => AppAlerts.displayDialogAndroid(
              context,
              const Text("Expense"),
              AppAlerts.expenseInput(
                usersDropdown(context, id, onChangedInputID),
                onChangedInputSpentMoney,
                onChangedInputSpentDesc,
              ),
              AppAlerts.addActionButtons(context, sendNewExpense),
            ),
          ),

          //Calculate
          ElevatedButton(
            onPressed: sendCalculateCosts,
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Calculate",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),

          //Add person
          FloatingActionButton(
            child: const Icon(
              Icons.person_add,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => AppAlerts.displayDialogAndroid(
                context,
                const Text("New User"),
                AppAlerts.nameInput(onChangedInputName),
                AppAlerts.addActionButtons(context, sendNewUser)),
          ),

          //Move to expense screen
          FloatingActionButton(
            heroTag: 123,
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => {},
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await updateInfo();
          setState(() {
            output = listToString(users);
          });
        },
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    output,
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendNewUser() async {
    await addUser(name);
    setState(() {
      output = listToString(users);
    });
  }

  Future<void> sendNewExpense() async {
    await addExpense(id.toString(), spentMoney.toString(), expenseDesc);
    setState(() {
      output = listToString(expenses);
    });
  }

  Future<void> sendCalculateCosts() async {
    await calculateCosts();
    setState(() {
      output = listToString(payments);
    });
  }

  dynamic onChangedInputName(String? value) {
    name = value!;
  }

  dynamic onChangedInputID(String? value) {
    var val = int.tryParse(value!);
    if (val == null) return;
    id = val;
  }

  dynamic onChangedInputSpentMoney(String? value) {
    var val = int.tryParse(value!);
    if (val == null) return;
    spentMoney = val;
  }

  dynamic onChangedInputSpentDesc(String? value) {
    expenseDesc = value!;
  }
}
