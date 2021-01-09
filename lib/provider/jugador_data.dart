import 'package:flutter/foundation.dart';

import 'package:la_red/model/jugador.dart';

import 'package:hive/hive.dart';

import '../constants.dart';

class JugadorData with ChangeNotifier {
  List<Jugador> _jugadores = [];
  static bool _read = false;
  final String _sizeDataBase = 'nPlayers';
  final String _identifierDataBase = 'player';

  List<Jugador> get getJugadores => _jugadores;
  Jugador getTeam(index) => _jugadores.elementAt(index);
  int get playerLength => _jugadores.length;

  void createPlayer() async {
    var box = await Hive.openBox(kBoxName);

    Jugador.counter = await box.get(_sizeDataBase, defaultValue: 0);
    print(Jugador.counter);

    await box.put('$_identifierDataBase${Jugador.counter}',
        Jugador.auto('Cristiano Ronaldo', Leagues.libre));
    await box.put('$_identifierDataBase${Jugador.counter}',
        Jugador.auto('Lionel Messi', Leagues.libre));
    await box.put('$_identifierDataBase${Jugador.counter}',
        Jugador.auto('Robert Lewandowski', Leagues.libre));
    await box.put('$_identifierDataBase${Jugador.counter}',
        Jugador.auto('Zlatan Ibrahimovic', Leagues.m30));
    await box.put('$_identifierDataBase${Jugador.counter}',
        Jugador.auto('Neymar JR', Leagues.m30));

    await box.put(_sizeDataBase, Jugador.counter);
    notifyListeners();
  }

  void readPLayers() async {
    var box = await Hive.openBox(kBoxName);
    Jugador.counter = await box.get(_sizeDataBase, defaultValue: 0);

    print('look at thisss ${Jugador.counter}');
    if (!_read) {
      for (int i = 0; i < Jugador.counter; i++) {
        var aux = await box.get('$_identifierDataBase$i');
        _jugadores.add(aux);
      }
      _read = true;
    }

    notifyListeners();
  }

  //TODO: Revisar esta función. Ahora esta eliminando el archivo de la lista, pero no de la base de datos
  void deletePlayer(int id) async {
    var box = await Hive.openBox(kBoxName);
    _jugadores.removeWhere((element) => element.dni == id);

    notifyListeners();
  }
}
