import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../models/tag.dart';
import '../providers/tags.dart';

class SelectTag extends StatefulWidget {
  SelectTag({Key? key}) : super(key: key);

  /* static const List<String> _kOptions = <String>[
    'family',
    'friends',
    'work',
  ]; */

  @override
  _SelectTagState createState() => _SelectTagState();
}

class _SelectTagState extends State<SelectTag> {
  bool isLoading = false;

  Future fetchAutoCompleteData() async {}
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    final listOptionsAutoComplete = Provider.of<Tags>(context).tags;
    /* final listTagNames = List.generate(listOptionsAutoComplete.length, (index) {
      return listOptionsAutoComplete[index].name;
    }); */
    final listTagNames = ['Friends', 'Family', 'Work'];
    print(listTagNames);
    return Container(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: listTagNames.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
