import '../providers/aniversaris.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './nou_aniversari_screen.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    final _listAniversaris = Provider.of<Aniversaris>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: ListView.builder(itemBuilder: (ctx, index) {
        return ListTile(
          leading: Text(_listAniversaris.aniversaris[index].id),
          title: Text(_listAniversaris.aniversaris[index].nom),
          subtitle: Text(
              _listAniversaris.aniversaris[index].dataNaixement.toString()),
        );
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return NouAniversariScreen();
              },
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
