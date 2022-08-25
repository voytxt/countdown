import 'package:countdown/countdown.dart';
import 'package:countdown/settings.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Precise Countdown',
      theme: ThemeData(
        // brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Settings(),
        '/countdown': (context) => const Countdown(),
      },
    );
  }
}

class CountdownArguments {
  final DateTime end;

  CountdownArguments(this.end);
}
