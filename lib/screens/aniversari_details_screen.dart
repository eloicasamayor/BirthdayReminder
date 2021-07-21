import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:aniversaris/models/aniversari.dart';
import '../providers/aniversaris.dart';
import './nou_aniversari_screen.dart';
import '../helpers/notification_service.dart';

class AniversariDetailsScreen extends StatefulWidget {
  final int id;
  String nom;
  String cognom1;
  String cognom2;
  DateTime dataNaixement;
  AniversariDetailsScreen({
    Key? key,
    required this.id,
    required this.nom,
    required this.cognom1,
    required this.cognom2,
    required this.dataNaixement,
  }) : super(key: key);

  @override
  _AniversariDetailsScreenState createState() =>
      _AniversariDetailsScreenState();
}

class _AniversariDetailsScreenState extends State<AniversariDetailsScreen> {
  _deleteAniversari(ctx) {
    Provider.of<Aniversaris>(ctx, listen: false).removeAniversari(widget.id);
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

  void _navigateToDetailsPageAndUpdate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return NouAniversariScreen(
            editando: true,
            id: widget.id,
          );
        },
      ),
    );
    if (result == true) {
      Aniversari? _aniversari = Provider.of<Aniversaris>(context, listen: false)
          .aniversariFromId(widget.id);
      setState(() {
        widget.nom = _aniversari.nom;
        widget.cognom1 = _aniversari.cognom1;
        widget.cognom2 = _aniversari.cognom2;
        widget.dataNaixement = _aniversari.dataNaixement;
      });
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${widget.nom}\'s birthday details updated'),
          ),
        );
    }
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Do you want to delete ${widget.nom}?'),
                      content: Text(
                          '${widget.nom} ${widget.cognom1} ${widget.cognom2} birthday will be delted'),
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
              _navigateToDetailsPageAndUpdate(context);
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Text(
                  widget.nom.substring(0, 1) + widget.cognom1.substring(0, 1),
                  style: Theme.of(context).textTheme.headline4,
                  textScaleFactor: 1.5,
                ),
                radius: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.nom + ' ' + widget.cognom1 + ' ' + widget.cognom2,
                style: Theme.of(context).textTheme.headline4,
              ),
              Divider(),
              Text('Years old'),
              Text(
                _howOldIs(widget.dataNaixement).toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              Divider(),
              Text('Birth Date'),
              Text(
                DateFormat('yMMMd').format(widget.dataNaixement),
                //DateFormat('dd-MM-yyyy').format(dataNaixement),
                style: Theme.of(context).textTheme.headline4,
              ),
              Divider(),
              (DateTime.now().month == widget.dataNaixement.month &&
                      DateTime.now().day == widget.dataNaixement.day)
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: Colors.amberAccent,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            'TODAY IS ${widget.nom.toUpperCase()} BIRTHDAY!',
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
                          _daysToNextBirthday(widget.dataNaixement).toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
