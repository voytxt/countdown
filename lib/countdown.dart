import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:countdown/main.dart';
import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  const Countdown({Key? key}) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  String _countdown = '';

  @override
  Widget build(BuildContext context) {
    // TODO: Fix this not working when going back to the previous route
    // hide status bar and navigation bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    final arguments = ModalRoute.of(context)!.settings.arguments as CountdownArguments;

    Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
      if (!mounted) return;
      final displayNumber = ((arguments.end.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch) / 100).floor() / 10;
      // TODO: End timer when countdown reaches 0
      setState(() => _countdown = displayNumber >= 0 ? displayNumber.toString() : '0');
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: AutoSizeText(
            _countdown,
            maxLines: 1,
            style: const TextStyle(fontSize: 999, fontWeight: FontWeight.w100),
          ),
        ),
      ),
    );
  }
}
