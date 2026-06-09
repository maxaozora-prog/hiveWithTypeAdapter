import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.deepPurple,
  useMaterial3: false,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepPurple,
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  textTheme: TextTheme(
    // bodyMedium: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleMedium: TextStyle(
        //color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
         color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
  ),
);

final darkTheme = ThemeData.dark(
  useMaterial3: false,
).copyWith(
  primaryColor: Colors.deepPurple,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.deepPurple,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Colors.deepPurple),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
  ),
);