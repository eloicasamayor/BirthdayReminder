import 'package:aniversaris/screens/nou_aniversari_screen.dart';
import 'package:flutter/material.dart';

class AniversariDetailsScreen extends StatelessWidget {
  final String nom;
  final String cognom1;
  final String cognom2;
  final DateTime dataNaixement;
  const AniversariDetailsScreen({
    Key? key,
    required this.nom,
    required this.cognom1,
    required this.cognom2,
    required this.dataNaixement,
  }) : super(key: key);

  Future<String?> _dialogDelete(ctx) {
    return showDialog<String>(
      context: ctx,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Do you want to delete $nom?'),
                      content: Text(
                          '$nom $cognom1 $cognom2 birthday will be delted'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
              icon: Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return NouAniversariScreen(true);
                    },
                  ),
                );
              },
              icon: Icon(Icons.edit)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nom),
            Text(cognom1),
            Text(cognom2),
            Text(dataNaixement.toString()),
          ],
        ),
      ),
    );
  }
}
