import 'dart:convert';
import 'dart:ffi';
import 'package:app/function.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = "";
  String query = "";
  var data;
  String output = "Initial output";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  name = "name=$value";
                },
              ),
              TextField(
                onChanged: (value) {
                  query = "query=$value";
                },
              ),
              TextButton(
                  onPressed: () async {
                    var url = "http://10.0.2.2:5000/add?$query&$name";
                    data = await fetchData(url);

                    var tagsJson = jsonDecode(data) as List;
                    List<User> users = tagsJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
                    setState(() {
                      //TODO: por cada user crear un panel donde muestre su info
                      output = users.map((user) => user.toString()).toString();
                    });
                  },
                  child: const Text("Send", style: TextStyle(fontSize: 30),)
              ),
              Text(output, style: const TextStyle(fontSize: 40, color: Colors.cyan),),
              TextButton(
                  onPressed: () async {
                    var url = "http://10.0.2.2:5000/calculate";
                    data = await fetchData(url);
                    var decoded = jsonDecode(data);
                    setState(() {
                      output = decoded['output'].toString();
                    });
                  },
                  child: const Text("Calculate", style: TextStyle(fontSize: 30),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  String name = "";
  int spentMoney = 0;

  User(this.name, this.spentMoney);

  factory User.fromJson(dynamic json){
    return User(json["name"] as String, json["spent_money"] as int);
  }

  @override
  String toString() {
    return '{ $name, $spentMoney }';
  }
}
