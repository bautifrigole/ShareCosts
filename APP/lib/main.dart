import 'package:app/screens/home_screen.dart';
import 'package:app/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main(List<String> args) => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: AppTheme.darkTheme,
    );
  }
}
