import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './lateral_menu.dart';
import '../widgets/list_aniversaris.dart';
import '../providers/aniversaris.dart';
import '../models/aniversari.dart';

import './nou_aniversari_screen.dart';

enum orderAniversariBy { id, nom, cognom1, cognom2, data, mes }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  String title;
  orderAniversariBy ordenar = orderAniversariBy.id;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  orderAniversariBy ordenar = orderAniversariBy.id;
  TextEditingController _searchFieldController = TextEditingController();
  var seeFilters = false;
  static final GlobalKey<FormFieldState<String>> _searchFormKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? isSearching = false;
  List<Aniversari> listSearchResult = [];

  void filterSearchResults(String query) {
    List<Aniversari> listAniversaris =
        Provider.of<Aniversaris>(context, listen: false).aniversaris;
    query = query.toLowerCase();
    if (query.isNotEmpty) {
      List<Aniversari> dummyListData = [];
      listAniversaris.forEach((item) {
        if (item.nom.toLowerCase().contains(query)) {
          dummyListData.add(item);
        } else if (item.cognom1.toLowerCase().contains(query)) {
          dummyListData.add(item);
        } else if (item.cognom2.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });

      setState(() {
        isSearching = true;
        listSearchResult.clear();
        listSearchResult.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        isSearching = false;
        //listAniversaris.clear();
        //listAniversaris.addAll(listAniversaris);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: LateralMenu(),
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              top: 12,
              bottom: 6,
              right: MediaQuery.of(context).size.width * 0.05,
              left: MediaQuery.of(context).size.width * 0.05,
            ),
            padding: EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                if (isSearching != false)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                if (isSearching != true)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: IconButton(
                      onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                      icon: Icon(Icons.menu),
                    ),
                  ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: _searchFieldController,
                    key: _searchFormKey,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black38,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    ),
                  ),
                ),
                if (isSearching != false)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        _searchFieldController.clear();
                        setState(() {
                          isSearching = false;
                        });
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                      ),
                    ),
                  ),
                if (isSearching != true)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          seeFilters = !seeFilters;
                        });
                      },
                      icon: Icon(
                        Icons.filter_alt,
                        color: seeFilters ? Colors.amber : Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        automaticallyImplyLeading: false, // hides leading widget

        backgroundColor: Colors.grey.shade300,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: Colors.black12,
              height: seeFilters ? 60 : 1,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 10),
                children: [
                  Text('order by:   '),
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
            if (isSearching == true)
              Expanded(
                child: ListAniversaris(listAniversaris: listSearchResult),
              ),
            if (isSearching != true)
              Expanded(
                child: FutureBuilder(
                  future: Provider.of<Aniversaris>(
                    context,
                    listen: false,
                  ).fetchAndSetAniversaris(ordenar),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Consumer<Aniversaris>(
                              child: Center(
                                child: Text('No birthdays yet'),
                              ),
                              builder: (ctx, aniversaris, _) {
                                return ListAniversaris(
                                  listAniversaris: Provider.of<Aniversaris>(
                                    context,
                                    listen: false,
                                  ).aniversarisOrdenados(ordenar),
                                );
                              },
                            ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return NouAniversariScreen(false);
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
