import 'package:flutter/material.dart';
import 'package:project1/logReg page/login.dart';
import 'package:project1/themes/themes.dart';
import 'package:provider/provider.dart';
import 'package:project1/themes/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(lightTheme),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeProvider.themeData,
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
