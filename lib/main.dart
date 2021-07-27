import 'package:aniversaris/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './providers/aniversaris.dart';
import './providers/tags.dart';
import './helpers/notification_service.dart';

import 'screens/settings_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /* ChangeNotifierProvider(
          create: (ctx) => Tags(),
        ), */

        ChangeNotifierProvider(
          create: (ctx) => Aniversaris(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Birthday Reminder',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          appBarTheme: AppBarTheme(color: Colors.grey[200]),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 14),
              minimumSize: Size.fromWidth(40),
              onPrimary: Colors.black45,
              primary: Colors.grey[400],
              padding: EdgeInsets.all(7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          textTheme: TextTheme(
            subtitle1: TextStyle(
              fontSize: 18,
            ),
            subtitle2: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        home: MyHomePage(title: 'Birthday Reminder'),
        routes: {
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/settings': (context) => SettingsScreen(),
        },
      ),
    );
  }
}
