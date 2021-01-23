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
  var _lastKeyEdited;

  List<Partido> get getPartidos => _partidos;
  Partido getMatchByIndex(index) => _partidos.elementAt(index);
  int get nMatches => _partidos.length;
  // int get lastKeyEdited => _lastKeyEdited;
  int get lastKeyEdited => _lastKeyEdited;

  Partido getMatchByKey(key) {
    return _partidos.firstWhere((element) => element.key == key);
  }

  void createMatch(Partido partido) async {
    _partidos.add(partido);
    var box = await Hive.openBox<Partido>(kBoxPartidos);
    box.add(partido);
    _lastKeyEdited = partido.key;
    notifyListeners();
  }

  void editMatch(Partido partido) async {
    var box = await Hive.openBox<Partido>(kBoxPartidos);
    partido.save();
    _lastKeyEdited = partido.key;
    notifyListeners();
  }

  void readMatches() async {
    var box = await Hive.openBox<Partido>(kBoxPartidos);
    print('box values partidos: ${box.values}');

    print('there are ${Partido.counter} games to play');
    if (!_read) {
      box.values.forEach((element) {
        print(
            'el partido entre ${element.equipo1.first.nombre} vs ${element.equipo2.first.nombre} es creado');
        _partidos.add(element);
      });
      _read = true;
    }

    notifyListeners();
  }

  //TODO: Revisar esta función. Ahora esta eliminando el archivo de la lista, pero no de la base de datos
  void deleteMatch(Partido partido) async {
    var box = await Hive.openBox<Partido>(kBoxPartidos);
    partido.delete();
    _lastKeyEdited = partido.key;
    _partidos.removeWhere((element) => element.id == partido.id);
    notifyListeners();
  }
}
