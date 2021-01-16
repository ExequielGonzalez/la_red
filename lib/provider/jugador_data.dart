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
  Jugador getPlayer(index) => _jugadores.elementAt(index);
  int get playerLength => _jugadores.length;

  // void createPlayer({bool auto = false}) async {
  //   var box = await Hive.openBox(kBoxName);
  //
  //   Jugador.counter = await box.get(_sizeDataBase, defaultValue: 0);
  //   print(Jugador.counter);
  //   if (auto) {
  //     await box.put('$_identifierDataBase${Jugador.counter}',
  //         Jugador.auto('Cristiano Ronaldo', Leagues.libre));
  //     await box.put('$_identifierDataBase${Jugador.counter}',
  //         Jugador.auto('Lionel Messi', Leagues.libre));
  //     await box.put('$_identifierDataBase${Jugador.counter}',
  //         Jugador.auto('Robert Lewandowski', Leagues.libre));
  //     await box.put('$_identifierDataBase${Jugador.counter}',
  //         Jugador.auto('Zlatan Ibrahimovic', Leagues.m30));
  //     await box.put('$_identifierDataBase${Jugador.counter}',
  //         Jugador.auto('Neymar JR', Leagues.m30));
  //   } else {
  //     print('creando jugador');
  //     await box.put('$_identifierDataBase${Jugador.counter}', Jugador());
  //   }
  //
  //   await box.put(_sizeDataBase, Jugador.counter);
  //   notifyListeners();
  // }

  // void createPlayer() async {
  //   var box = await Hive.openBox(kBoxName);
  //
  //   Jugador.counter = await box.get(_sizeDataBase, defaultValue: 0);
  //   print(Jugador.counter);
  //   print('creando jugador');
  //
  //   var aux = Jugador(
  //     nombre: '',
  //     apellido: '',
  //     amarillas: 0,
  //     dni: 0,
  //     edad: 0,
  //     goles: 0,
  //     liga: Leagues.libre.toString(),
  //     posicion: 0,
  //     rojas: 0,
  //   );
  //   _jugadores.add(aux);
  //   await box.put('$_identifierDataBase${Jugador.counter}', aux);
  //
  //   await box.put(_sizeDataBase, Jugador.counter);
  //   notifyListeners();
  // }

  void createPlayer(Jugador jugador) async {
    _jugadores.add(jugador);
    var box = await Hive.openBox(kBoxName);

    int totalJugadores = await box.get(_sizeDataBase, defaultValue: 0) + 1;
    print(totalJugadores);
    print('creando jugador');

    await box.put('$_identifierDataBase$totalJugadores', jugador);

    await box.put(_sizeDataBase, totalJugadores);
    notifyListeners();
  }

  void editPlayer(Jugador jugador) async {
    print('editando el jugador: ${jugador.toString()}');
    print('editando el jugador: ${jugador.nombre}');
    var box = await Hive.openBox(kBoxName);
    var aux = await box.get('$_identifierDataBase${jugador.id}');
    aux = jugador;
    await box.put('$_identifierDataBase${jugador.id}', aux);
    notifyListeners();
  }

  // void readPlayers({bool force = false}) async {
  //   var box = await Hive.openBox(kBoxName);
  //   Jugador.counter = await box.get(_sizeDataBase, defaultValue: 0);
  //
  //   print('hay creados ${Jugador.counter} jugadores');
  //   if (!_read || force) {
  //     print('y aca entro?');
  //     for (int i = 0; i < Jugador.counter; i++) {
  //       var aux = await box.get('$_identifierDataBase$i');
  //       // print('el jugador ${aux.nombre} es creado');
  //       _jugadores.add(aux);
  //     }
  //     _read = true;
  //   }
  //
  //   notifyListeners();
  // }

  void readPlayers({bool force = false}) async {
    var box = await Hive.openBox(kBoxName);
    Jugador.counter = await box.get(_sizeDataBase, defaultValue: 0);

    print('hay creados ${Jugador.counter} jugadores');
    if (!_read || force) {
      print('y aca entro?');
      for (int i = 1; i <= Jugador.counter; i++) {
        var aux = await box.get('$_identifierDataBase$i', defaultValue: false);

        if (aux != false) {
          print('el jugador ${aux.nombre} es creado');
          _jugadores.add(aux);
        }
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
