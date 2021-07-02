import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/aniversaris.dart';
import '../widgets/tag.dart';

class NouAniversariScreen extends StatefulWidget {
  final bool editando;
  NouAniversariScreen(this.editando);
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
    if (_nomController.text.isEmpty || _data == null) {
      print('error, falta algo');
      return;
    } else {
      Provider.of<Aniversaris>(context, listen: false).addAniversari(
        _nomController.text,
        _cognom1Controller.text,
        _cognom2Controller.text,
        _data,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editando ? 'Editando' : 'Nou Aniversari'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Name'),
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
          Row(
            children: [
              Text(
                _dataNaixementStr == null
                    ? 'data naixement'
                    : _dataNaixementStr.toString(),
              ),
              TextButton.icon(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1921, 1, 1),
                      maxTime: DateTime.now(), onChanged: (date) {
                    print(
                      'change $date in time zone ${date.timeZoneOffset.inHours.toString()}',
                    );
                  }, onConfirm: (date) {
                    print('confirm $date');
                    _dataNaixementEscollida = date;
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(date);
                    setState(() {
                      _dataNaixementStr = formattedDate;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                icon: Icon(Icons.date_range_outlined),
                label: Text('Escollir'),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () => _guardarAniversari(_dataNaixementEscollida),
            icon: Icon(Icons.save),
            label: Text('Guardar'),
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
    );
  }
}
