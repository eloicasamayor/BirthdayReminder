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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
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
