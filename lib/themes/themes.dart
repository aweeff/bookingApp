import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  hintColor: Colors.blueAccent,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey[900],
  hintColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: Colors.grey[850],
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blueGrey,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
  ),
);

final ThemeData customColorfulTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
  hintColor: Colors.amber,
  scaffoldBackgroundColor: Colors.lightGreen[50],
  appBarTheme: const AppBarTheme(
    color: Colors.deepPurple,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.amber,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(color: Colors.deepPurple),
    bodyLarge: TextStyle(color: Colors.deepPurple[900]),
  ),
);




