import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

  int _howOldIs(DateTime birthDate) {
    return DateTime.now().difference(birthDate).inDays ~/ 365;
  }

  int _daysToNextBirthday(DateTime birthDate) {
    var nextBirthDay =
        DateTime(DateTime.now().year, birthDate.month, birthDate.day);
    if (nextBirthDay.isBefore(DateTime.now())) {
      nextBirthDay =
          DateTime(DateTime.now().year + 1, birthDate.month, birthDate.day);
    }
    return _daysBetween(DateTime.now(), nextBirthDay);
  }

  int _daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details'), actions: [
        IconButton(
            onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text('Do you want to delete $nom?'),
                    content:
                        Text('$nom $cognom1 $cognom2 birthday will be delted'),
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
      ]),
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Text(
                nom.substring(0, 1) + cognom1.substring(0, 1),
                style: Theme.of(context).textTheme.headline4,
                textScaleFactor: 1.5,
              ),
              radius: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              nom + ' ' + cognom1 + ' ' + cognom2,
              style: Theme.of(context).textTheme.headline4,
            ),
            Divider(),
            Text('Years old'),
            Text(
              _howOldIs(dataNaixement).toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            Divider(),
            Text('Birth Date'),
            Text(
              DateFormat('dd-MM-yyyy').format(dataNaixement),
              style: Theme.of(context).textTheme.headline4,
            ),
            Divider(),
            (DateTime.now().month == dataNaixement.month &&
                    DateTime.now().day == dataNaixement.day)
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.amberAccent,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'TODAY IS ${nom.toUpperCase()} BIRTHDAY!',
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Icon(Icons.cake),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Text('Days to next birthday'),
                      Text(
                        _daysToNextBirthday(dataNaixement).toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
