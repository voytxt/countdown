import 'package:countdown/countdown.dart';
import 'package:countdown/settings.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  final _theme = ThemeData(
    colorScheme: const ColorScheme.light(),
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Colors.indigoAccent[700],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precise Countdown',
      theme: _theme,
      darkTheme: _theme.copyWith(
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const Settings(),
        '/countdown': (context) => const Countdown(),
      },
    );
  }

  ThemeMode getTheme() => _themeMode;
  void changeTheme(ThemeMode themeMode) => setState(() => _themeMode = themeMode);
}

class CountdownArguments {
  final DateTime end;

  CountdownArguments(this.end);
}
