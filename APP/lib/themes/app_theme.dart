import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromARGB(255, 110, 57, 255);
  static Color textPrimary = Color.fromARGB(255, 162, 128, 255);

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      // Color primario
      primaryColor: primary,

      // AppBar Theme
      appBarTheme:
          const AppBarTheme(color: primary, elevation: 0, centerTitle: true),

      // Text button tema
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary)),

      // tema Boton flotante
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary, elevation: 0, iconSize: 35),

      // elevated Button theme

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              shape: const StadiumBorder(),
              elevation: 0)),
      // input decoration theme
      inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: textPrimary),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textPrimary),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: textPrimary),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))));

  // appBar theme

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      // Color primario
      primaryColor: primary,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        color: primary,
        elevation: 0,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primary)),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: primary));
}
