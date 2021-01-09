import 'package:flutter/foundation.dart';

import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/partido.dart';

import 'package:hive/hive.dart';
import 'package:la_red/provider/leagues_provider.dart';

import '../constants.dart';

class PartidoData with ChangeNotifier {
  List<Partido> _partidos = [];
  static bool _read = false;
  final String _sizeDataBase = 'nMatches';
  final String _identifierDataBase = 'match';

  List<Partido> get getPartidos => _partidos;
  Partido getMatch(index) => _partidos.elementAt(index);
  int get nMatches => _partidos.length;

  void createMatchAuto() async {
    var box = await Hive.openBox(kBoxName);

    Partido.counter = await box.get(_sizeDataBase, defaultValue: 0);
    print(Partido.counter);
    await box.put('$_identifierDataBase${Partido.counter}',
        Partido.autoT1T2(Equipo.auto(), Equipo.auto(), Leagues.libre));

    await box.put(_sizeDataBase, Partido.counter);
    notifyListeners();
  }

  // void createMatch(Equipo equipo1,Equipo equipo2 ) async {
  //   var box = await Hive.openBox(kBoxName);
  //
  //   Partido.counter = await box.get('nMatches', defaultValue: 0);
  //   print(Partido.counter);
  //   await box.put('match${Partido.counter}',
  //       Partido.autoT1T2(Equipo.auto(), Equipo.auto(), Leagues.libre));
  //
  //
  //   await box.put('size', Equipo.counter);
  //   notifyListeners();
  // }

  void readMatches() async {
    var box = await Hive.openBox(kBoxName);
    Partido.counter = await box.get(_sizeDataBase, defaultValue: 0);

    print('there are ${Partido.counter} games to play');
    if (!_read) {
      for (int i = 0; i < Partido.counter; i++) {
        var aux = await box.get('$_identifierDataBase$i');
        _partidos.add(aux);
      }
      _read = true;
    }

    notifyListeners();
  }

  //TODO: Revisar esta función. Ahora esta eliminando el archivo de la lista, pero no de la base de datos
  void deleteMatch(int id) async {
    var box = await Hive.openBox(kBoxName);
    _partidos.removeWhere((element) => element.id == id);

    notifyListeners();
  }
}
