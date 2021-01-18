import 'package:flutter/foundation.dart';

import 'package:la_red/model/jugador.dart';

import 'package:hive/hive.dart';

import 'dart:developer' as dev;

import '../constants.dart';

class JugadorData with ChangeNotifier {
  List<Jugador> _jugadores = [];
  static bool _read = false;
  final String _sizeDataBase = 'nPlayers';
  final String _identifierDataBase = 'player';

  int _size = -1;

  List<Jugador> get getJugadores => _jugadores;
  Jugador getPlayer(index) => _jugadores.elementAt(index);
  int get playerLength => _jugadores.length;

  void createPlayer(Jugador jugador) async {
    _size += 1;
    jugador.keyDataBase = '$_identifierDataBase$_size';
    _jugadores.add(jugador);
    var box = await Hive.openBox(kBoxJugadores);

    print(
        'creando jugador ${jugador.nombre} con el id: ${jugador.id} y n: ${_size}}');

    // box.put(jugador.keyDataBase, jugador);
    box.add(jugador);

    // box.put(_sizeDataBase, _size);
    notifyListeners();
  }

  void editPlayer(Jugador jugador) async {
    print('editando el jugador: ${jugador.toString()}');
    print('editando el jugador: ${jugador.nombre} con el id: ${jugador.id}');
    var box = await Hive.openBox(kBoxJugadores);
    // var aux = await box.get('$_identifierDataBase${jugador.id}');
    // aux = jugador;
    // dev.debugger();
    // await box.put('$_identifierDataBase${jugador.id}', jugador);

    //esto servia
    // box.put(jugador.key, jugador);
    jugador.save();
    notifyListeners();
  }

  void readPlayers({bool force = false}) async {
    var box = await Hive.openBox(kBoxJugadores);
    // box.clear();
    print('box values: ${box.values}');

    // _size = await box.get(_sizeDataBase, defaultValue: 0);
    // print('el tamaño de la database de jugadores es: $_size');
    // dev.debugger();
    // if (_size != -1) Jugador.counter = _size;

    print('hay creados ${Jugador.counter} jugadores');
    if (!_read || force) {
      box.values.forEach((element) {
        print('el jugador ${element.nombre} es creado');
        _jugadores.add(element);
      });
      // for (int i = 1; i <= Jugador.counter; i++) {
      //   var aux = await box.get('$_identifierDataBase$i', defaultValue: false);
      //
      //   if (aux != false) {
      //     print('el jugador ${aux.nombre} es creado');
      //     _jugadores.add(aux);
      //   } else
      //     print('y esto que onda?');
      // }
      _read = true;
    }

    notifyListeners();
  }

  //TODO: Revisar esta función. Ahora esta eliminando el archivo de la lista, pero no de la base de datos
  void deletePlayer(Jugador jugador) async {
    print('eliminando el jugador ${jugador.toString()}');
    // dev.debugger();
    var box = await Hive.openBox(kBoxJugadores);
    // String _key = jugador.keyDataBase;
    // print('que onda esta key perro: ${jugador.key}');
    jugador.delete();
    // await box.delete(jugador.key);
    _jugadores.removeWhere((element) => element.id == jugador.id);
    _size -= 1;
    // await box.put(_sizeDataBase, _size);
    // print(box.containsKey('$_key'));
    notifyListeners();
  }
}
