import 'package:aniversaris/models/aniversari.dart';
//import 'package:aniversaris/widgets/select_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/aniversaris.dart';
import '../helpers/notification_service.dart';
//import '../widgets/tag.dart';

class NouAniversariScreen extends StatefulWidget {
  final bool editando;
  final int? id;
  NouAniversariScreen({required this.editando, this.id});
  @override
  _NouAniversariScreenState createState() => _NouAniversariScreenState();
}

class _NouAniversariScreenState extends State<NouAniversariScreen> {
  final _nomController = TextEditingController();
  final _cognom1Controller = TextEditingController();
  final _cognom2Controller = TextEditingController();
  String? _dataNaixementStr;
  DateTime? _dataNaixementEscollida;

  /*
  final _tagsController = TextEditingController();
  String? _tagsInput;
  List<TagWidget> _tagsList = [];
  void _novaTag() {
    setState(() {
      _tagsList.add(TagWidget(_tagsController.text));
      _tagsController.clear();
    });
  }
  */

  void _guardarAniversari(_data) {
    if (_nomController.text.isEmpty ||
        _cognom1Controller.text.isEmpty ||
        _cognom2Controller.text.isEmpty ||
        _data == null) {
      //print('error, falta algo');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something is missing!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    } else {
      Provider.of<Aniversaris>(context, listen: false)
          .addAniversari(
            _nomController.text,
            _cognom1Controller.text,
            _cognom2Controller.text,
            _data,
          )
          .then((value) => Navigator.pop(context));
    }
  }

  void _editarAniversari(_data) {
    //print('EDITANT ANIVERSARI...');
    if (_nomController.text.isEmpty ||
        _cognom1Controller.text.isEmpty ||
        _cognom2Controller.text.isEmpty ||
        _data == null) {
      //print('error, falta algo');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something is missing!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      return;
    } else {
      Provider.of<Aniversaris>(context, listen: false)
          .editAniversari(
            widget.id!,
            _nomController.text,
            _cognom1Controller.text,
            _cognom2Controller.text,
            _data,
          )
          .then((value) => Navigator.pop(context, true));
    }
  }

  @override
  void initState() {
    print('init');
    if (widget.id != null) {
      Aniversari? _aniversari = Provider.of<Aniversaris>(context, listen: false)
          .aniversariFromId(widget.id!);
      _dataNaixementEscollida = _aniversari.dataNaixement;
      _dataNaixementStr =
          DateFormat('dd / MM / yyyy').format(_dataNaixementEscollida!);
      _nomController.text = _aniversari.nom;
      _cognom1Controller.text = _aniversari.cognom1;
      _cognom2Controller.text = _aniversari.cognom2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Aniversari? _aniversari;
    if (widget.id != null) {
      print('widget.id= ${widget.id}');
      _aniversari = Provider.of<Aniversaris>(context, listen: false)
          .aniversariFromId(widget.id!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editando ? 'Editing' : 'New Birthday'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  NotificationService().listAllPendingNotifications(),
              icon: Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                controller: _nomController,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'First Surname'),
                controller: _cognom1Controller,
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Second Surname'),
                controller: _cognom2Controller,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _dataNaixementStr == null
                        ? 'Birth Date'
                        : _dataNaixementStr.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[200]!),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1921, 1, 1),
                          maxTime: DateTime.now(), onChanged: (date) {
                        /* print(
                          'change $date in time zone ${date.timeZoneOffset.inHours.toString()}',
                        ); */
                      }, onConfirm: (date) {
                        //print('confirm $date');
                        _dataNaixementEscollida = date;
                        String formattedDate =
                            DateFormat('dd / MM / yyyy').format(date);
                        setState(() {
                          _dataNaixementStr = formattedDate;
                        });
                      },
                          currentTime: widget.editando
                              ? _dataNaixementEscollida
                              : DateTime.now(),
                          locale: LocaleType.en,
                          theme: DatePickerTheme(
                            containerHeight: 270,
                          ));
                    },
                    icon: Icon(Icons.date_range_outlined),
                    label: Text(
                      'Choose birth date',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              /* SizedBox(
                height: 10,
              ),
              Text('Tags'),
              SelectTag(), */
              SizedBox(
                height: 40,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.85,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  icon: Icon(Icons.save),
                  label: Text((!widget.editando) ? 'Save' : 'Update'),
                  onPressed: !widget.editando
                      ? () {
                          _guardarAniversari(_dataNaixementEscollida);
                        }
                      : () => _editarAniversari(_dataNaixementEscollida),
                ),
              ),
              /*
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tags',
                      ),
                      controller: _tagsController,
                      onChanged: (_) {},
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _novaTag,
                    icon: Icon(Icons.add),
                    label: Text('Afegir'),
                  ),
                ],
              ),
              Wrap(
                children: _tagsList,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
