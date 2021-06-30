import '../providers/aniversaris.dart';
import '../models/aniversari.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './nou_aniversari_screen.dart';

enum orderAniversariBy { id, nom, cognom1, cognom2, data, mes }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  String title;
  orderAniversariBy ordenar = orderAniversariBy.id;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  orderAniversariBy ordenar = orderAniversariBy.id;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _listAniversaris;
    switch (ordenar) {
      case orderAniversariBy.id:
        {
          _listAniversaris = Provider.of<Aniversaris>(context).aniversaris;
        }
        break;
      case orderAniversariBy.nom:
        {
          _listAniversaris =
              Provider.of<Aniversaris>(context).aniversarisOrdenatsPerNom;
        }
        break;
      case orderAniversariBy.cognom1:
        {
          _listAniversaris =
              Provider.of<Aniversaris>(context).aniversarisOrdenatsPerCognom1;
        }
        break;
      case orderAniversariBy.cognom2:
        {
          _listAniversaris =
              Provider.of<Aniversaris>(context).aniversarisOrdenatsPerCognom2;
        }
        break;
      case orderAniversariBy.data:
        {
          _listAniversaris =
              Provider.of<Aniversaris>(context).aniversarisOrdenatsPerData;
        }
        break;
      case orderAniversariBy.mes:
        {
          _listAniversaris =
              Provider.of<Aniversaris>(context).aniversarisOrdenatsPerMes;
        }
        break;
      default:
        {
          _listAniversaris = Provider.of<Aniversaris>(context).aniversaris;
        }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.075,
            color: Colors.black12,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                Text('Order by:  '),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ordenar = orderAniversariBy.id;
                    });
                  },
                  child: Text('id'),
                  style: ButtonStyle(
                    backgroundColor: ordenar == orderAniversariBy.id
                        ? MaterialStateProperty.all<Color>(Colors.green)
                        : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ordenar = orderAniversariBy.nom;
                    });
                  },
                  child: Text('Name'),
                  style: ButtonStyle(
                    backgroundColor: ordenar == orderAniversariBy.nom
                        ? MaterialStateProperty.all<Color>(Colors.green)
                        : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ordenar = orderAniversariBy.cognom1;
                    });
                  },
                  child: Text('Surname1'),
                  style: ButtonStyle(
                    backgroundColor: ordenar == orderAniversariBy.cognom1
                        ? MaterialStateProperty.all<Color>(Colors.green)
                        : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ordenar = orderAniversariBy.cognom2;
                    });
                  },
                  child: Text('Surname2'),
                  style: ButtonStyle(
                    backgroundColor: ordenar == orderAniversariBy.cognom2
                        ? MaterialStateProperty.all<Color>(Colors.green)
                        : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ordenar = orderAniversariBy.data;
                    });
                  },
                  child: Text('birth date'),
                  style: ButtonStyle(
                    backgroundColor: ordenar == orderAniversariBy.data
                        ? MaterialStateProperty.all<Color>(Colors.green)
                        : null,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ordenar = orderAniversariBy.mes;
                    });
                  },
                  child: Text('month'),
                  style: ButtonStyle(
                    backgroundColor: ordenar == orderAniversariBy.mes
                        ? MaterialStateProperty.all<Color>(Colors.green)
                        : null,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            color: Colors.green,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: Text(_listAniversaris[index].id.toString()),
                  title: Text(
                      '${_listAniversaris[index].nom} ${_listAniversaris[index].cognom1} ${_listAniversaris[index].cognom2}'),
                  subtitle: Text(
                    _listAniversaris[index]
                        .dataNaixement
                        .toString()
                        .substring(0, 10),
                  ),
                );
              },
              itemCount: _listAniversaris.length,
            ),
          ),
        ],
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
