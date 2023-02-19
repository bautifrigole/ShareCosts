import 'dart:convert';
import 'package:app/function.dart';
import 'package:app/payment.dart';
import 'package:app/user.dart';
import 'package:flutter/material.dart';

const String ip = "http://10.0.2.2:5000/";
const String addUserKey = "add_user";
const String addMoneyKey = "add_money";
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
  String data = "";
  String output = "Initial output";
  List<User> users = [];
  List<Payment> payments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Name: ", style: TextStyle(fontSize: 20, color: Colors.black),),
              TextField(
                onChanged: (value) {
                  name = "name=$value";
                },
              ),
              TextButton(
                  onPressed: addUser,
                  child: const Text("Add person", style: TextStyle(fontSize: 30),)
              ),
              const Divider(height: 20),

              const Text("ID: ", style: TextStyle(fontSize: 20, color: Colors.black),),
              TextField(
                onChanged: (value) {
                  var val = int.tryParse(value);
                  if (val == null) return;
                  id = "id=$val";
                },
              ),
              const Divider(color: Colors.white,height: 20),
              const Text("Money: ", style: TextStyle(fontSize: 20, color: Colors.black),),
              TextField(
                onChanged: (value) {
                  var val = int.tryParse(value);
                  if (val == null) return;
                  spentMoney = "spent_money=$val";
                },
              ),
              TextButton(
                  onPressed: addMoney,
                  child: const Text("Add money", style: TextStyle(fontSize: 30),)
              ),
              const Divider(height: 20),

              Text(output, style: const TextStyle(fontSize: 40, color: Colors.cyan),),
              TextButton(
                  onPressed: calculateCosts,
                  child: const Text("Calculate", style: TextStyle(fontSize: 30),)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    var url = "${ip+addUserKey}?$name";
    data = await fetchData(url);

    var tagsJson = jsonDecode(jsonDecode(data)['users']) as List;
    users = tagsJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
    setState(updateUsersInfo);
  }

  Future<void> addMoney() async {
    var url = "${ip+addMoneyKey}?$id&$spentMoney";
    data = await fetchData(url);

    var tagsJson = jsonDecode(jsonDecode(data)['users']) as List;
    users = tagsJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
    setState(updateUsersInfo);
  }

  Future<void> calculateCosts() async {
    var url = ip+calculateKey;
    data = await fetchData(url);
    // TODO: hay que ver si funciona esto
    var tagsJson = jsonDecode(jsonDecode(data)['reckoning']) as List;
    payments = tagsJson.map((payJson) => Payment.fromJson(jsonDecode(payJson))).toList();
    setState(() {
      output = payments.toString();
    });
  }

  void updateUsersInfo(){
    //TODO: por cada user crear un panel donde muestre su info
    output = users.map((user) => user.toString()).toString();
  }
}
