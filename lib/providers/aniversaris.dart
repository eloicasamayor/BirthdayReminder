import 'package:aniversaris/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';

import '../models/aniversari.dart';

class Aniversaris with ChangeNotifier {
  List<Aniversari> _aniversaris = [];

  List<Aniversari> get aniversaris {
    return [..._aniversaris];
  }

  Future<void> addAniversari(
    String nomEscollit,
    DateTime dataNaixementEscollida,
  ) async {
    final nouAniversari = Aniversari(
      id: DateTime.now().toString(),
      nom: nomEscollit,
      dataNaixement: dataNaixementEscollida,
    );
    _aniversaris.add(nouAniversari);
    final mapGuardar = {
      'id': nouAniversari.id,
      'nom': nouAniversari.nom,
      'dataNaixement': nouAniversari.dataNaixement.toIso8601String(),
    };
    notifyListeners();
    DBHelper.insert('aniversaris', mapGuardar);
  }
}
