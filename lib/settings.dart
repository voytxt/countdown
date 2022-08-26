import 'package:countdown/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  DateTime _endDateTime = DateTime.now();

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _endDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 500)),
    );

    if (selectedDate != null) {
      setState(() {
        _endDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, _endDateTime.hour, _endDateTime.minute);
      });
    }
  }

  Future<void> _selectTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_endDateTime),
    );

    if (selectedTime != null) {
      setState(() {
        _endDateTime = DateTime(
          _endDateTime.year,
          _endDateTime.month,
          _endDateTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
  }

  String _getMonthName(int index) => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][index - 1];

  @override
  Widget build(BuildContext context) {
    // show status bar and navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Precise Countdown'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('End Date & Time'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _selectDate,
                    child: Text('${_endDateTime.day} ${_getMonthName(_endDateTime.month)} ${_endDateTime.year}'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: Text('${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Dark Mode'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      MyApp.of(context).changeTheme(MyApp.of(context).getTheme() == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
                    },
                    child: const Text('Change Theme'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/countdown',
            arguments: CountdownArguments(_endDateTime),
          );

          // hide status bar and navigation bar
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        },
        tooltip: 'Start',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
