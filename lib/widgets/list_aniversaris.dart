import 'package:aniversaris/screens/aniversari_details_screen.dart';
import 'package:flutter/material.dart';
import '../models/aniversari.dart';

class ListAniversaris extends StatelessWidget {
  final List<Aniversari> listAniversaris;

  const ListAniversaris({
    Key? key,
    required this.listAniversaris,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listAniversaris.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AniversariDetailsScreen(
                      nom: listAniversaris[i].nom,
                      cognom1: listAniversaris[i].cognom1,
                      cognom2: listAniversaris[i].cognom2,
                      dataNaixement: listAniversaris[i].dataNaixement),
                ),
              );
            },
            key: new Key(i.toString()),
            leading: CircleAvatar(
              child: Text(
                  '${listAniversaris[i].nom.substring(0, 1).toUpperCase()}${listAniversaris[i].cognom1.substring(0, 1).toUpperCase()}'),
            ),
            title: Text(
                '${listAniversaris[i].nom} ${listAniversaris[i].cognom1} ${listAniversaris[i].cognom2}'),
            subtitle: Text(
              listAniversaris[i].dataNaixement.toString().substring(0, 10),
            ),
          );
        });
  }
}
