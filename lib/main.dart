import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project1/localizations/l10n.dart';
import 'package:provider/provider.dart';
import 'logReg page/login.dart';
import 'themes/themes.dart';
import 'themes/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(lightTheme),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeProvider.themeData,
            locale: _locale,
            supportedLocales: [
              Locale('en', ''),
              Locale('ru', ''),
              Locale('kk', ''),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
