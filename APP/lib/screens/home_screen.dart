import 'package:app/app_alerts.dart';
import 'package:app/domain/domain.dart';
import 'package:app/expense_panel.dart';
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
          title: const Text("Costs Calculator"),
          backgroundColor: AppTheme.primary),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Clean users
          FloatingActionButton(
            heroTag: "fb1",
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
            heroTag: "fb2",
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
            onPressed: () async {
              await sendCalculateCosts();
              AppAlerts.displayDialogAndroid(
                  context, const Text("Calculate"), Text(output), [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Ok",
                      style: TextStyle(color: AppTheme.textPrimary),
                    )),
              ]);
            },
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
            heroTag: "fb3",
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
            heroTag: "fb4",
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () => Navigator.pushNamed(context, 'expenses'),
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
        child: ListView.separated(
          padding: const EdgeInsetsDirectional.all(10),
          itemBuilder: (BuildContext context, int index) {
            return expensePanel(context, expenses[index]);
          },
          itemCount: expenses.length,
          separatorBuilder: (_, __) => const Divider(
            height: 20,
            indent: 0,
          ),
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
