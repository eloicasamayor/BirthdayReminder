import 'package:aniversaris/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/aniversaris.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Aniversaris(),
      child: MaterialApp(
        title: 'Bday Remind',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Bday Remind'),
      ),
    );
  }
}
