import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/aniversaris.dart';
import './nou_aniversari_screen.dart';
import '../helpers/notification_service.dart';

class AniversariDetailsScreen extends StatelessWidget {
  final int id;
  final String nom;
  final String cognom1;
  final String cognom2;
  final DateTime dataNaixement;
  const AniversariDetailsScreen({
    Key? key,
    required this.id,
    required this.nom,
    required this.cognom1,
    required this.cognom2,
    required this.dataNaixement,
  }) : super(key: key);

  _deleteAniversari(ctx) {
    Provider.of<Aniversaris>(ctx, listen: false).removeAniversari(id);
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
                  ).then((value) {
                    if (value == 'OK') {
                      _deleteAniversari(context);
                    }
                  }).then((_) => Navigator.pop(context)),
              icon: Icon(Icons.delete)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NouAniversariScreen(
                      editando: true,
                      id: id,
                    );
                  },
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () async {
              await NotificationService().flutterLocalNotificationsPlugin.show(
                  12345,
                  "Today is ---- birthday!",
                  "Remember to congratulate ----.",
                  NotificationService.platformChannelSpecifics,
                  payload: 'data');
            },
            icon: Icon(Icons.notifications),
          ),
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
            Text(DateFormat('dd-MM-yyyy').format(dataNaixement)),
          ],
        ),
      ),
    );
  }
}
