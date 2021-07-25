import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);
  TimeOfDay timeInDay = TimeOfDay(hour: 13, minute: 0);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    widget.timeInDay = TimeOfDay(hour: 13, minute: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.timeInDay.hour);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 150,
          width: double.infinity,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Birthday Notification hour',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    '${widget.timeInDay.hour}:${widget.timeInDay.minute}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Future<TimeOfDay?> selectedTime = showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        ).then((value) {
                          print('value= ${value!.hour.toString()}');
                          setState(() {
                            widget.timeInDay = value;
                          });
                        });
                      },
                      child: Text(
                        'select time in day',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
