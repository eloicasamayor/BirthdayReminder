import '../providers/aniversaris.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './nou_aniversari_screen.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    final _listAniversaris = Provider.of<Aniversaris>(context).aniversaris;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return ListTile(
            leading: Text(_listAniversaris[index].id.toString()),
            title: Text(_listAniversaris[index].nom),
            subtitle: Text(_listAniversaris[index].dataNaixement.toString()),
          );
        },
        itemCount: _listAniversaris.length,
      ),
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
