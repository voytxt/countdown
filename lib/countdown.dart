import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:countdown/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Countdown extends StatefulWidget {
  const Countdown({Key? key}) : super(key: key);

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  String _countdown = '';
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as CountdownArguments;

    // if the periodic timer already exists, don't create a new one
    _timer ??= Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!mounted) {
        // cancel the timer after we leave the countdown screen
        _timer?.cancel();

        // show status bar and navigation bar
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

        return;
      }

      final difference = arguments.end.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch;
      final displayNumber = (difference / 100).floor() / 10;

      if (displayNumber >= 0) {
        setState(() => _countdown = displayNumber.toString());
      } else {
        setState(() => _countdown = 'DONE');
        _timer?.cancel();
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
