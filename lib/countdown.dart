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
      // Cancel the timer after we leave the countdown screen
      if (!mounted) {
        timer.cancel();
        return;
      }

      final difference = arguments.end.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
      final displayNumber = (difference / 100).floor() / 10;

      if (displayNumber >= 0) {
        setState(() => _countdown = displayNumber.toString());
      } else {
        setState(() => _countdown = 'DONE');
        timer.cancel();
      }
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
