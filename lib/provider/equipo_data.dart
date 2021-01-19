import 'package:flutter/foundation.dart';

import 'package:la_red/model/equipo.dart';

import 'package:hive/hive.dart';

import '../constants.dart';

class EquipoData with ChangeNotifier {
  List<Equipo> _equipos = [];
  static bool _read = false;
  final String _sizeDataBase = 'size';
  final String _identifierDataBase = 'eq';

  List<Equipo> get getEquipos => _equipos;
  Equipo getTeam(index) => _equipos.elementAt(index);
  int get teamLength => _equipos.length;

  // void createTeam() async {
  //   var box = await Hive.openBox(kBoxName);
  //
  //   Equipo.counter = await box.get(_sizeDataBase, defaultValue: 0);
  //   print(Equipo.counter);
  //   await box.put('$_identifierDataBase${Equipo.counter}',
  //       Equipo.autoNameLeague('Real Madrid', Leagues.libre));
  //   await box.put('$_identifierDataBase${Equipo.counter}',
  //       Equipo.autoNameLeague('Barcelona', Leagues.libre));
  //   await box.put('$_identifierDataBase${Equipo.counter}',
  //       Equipo.autoNameLeague('Bayer Leverkusen', Leagues.libre));
  //   await box.put('$_identifierDataBase${Equipo.counter}',
  //       Equipo.autoNameLeague('Schalke 04', Leagues.femenino));
  //   await box.put('$_identifierDataBase${Equipo.counter}',
  //       Equipo.autoNameLeague('borussia mönchengladbach', Leagues.femenino));
  //   await box.put('$_identifierDataBase${Equipo.counter}',
  //       Equipo.autoNameLeague('Boca Juniors', Leagues.m30));
  //   await box.put('$_identifierDataBase${Equipo.counter}',
  //       Equipo.autoNameLeague('River Plate', Leagues.m30));
  //
  //   await box.put(_sizeDataBase, Equipo.counter);
  //   notifyListeners();
  // }

  void createTeam(Equipo equipo) async {
    // _size += 1;
    // equipo.keyDataBase = '$_identifierDataBase$_size';
    _equipos.add(equipo);
    var box = await Hive.openBox(kBoxEquipos);

    print('creando equipo ${equipo.nombre} con el id: ${equipo.id} ');

    // box.put(jugador.keyDataBase, jugador);
    box.add(equipo);

    // box.put(_sizeDataBase, _size);
    notifyListeners();
  }

  void editTeam(Equipo equipo) async {
    print('editando el equipo: ${equipo.toString()}');
    print('editando el equipo: ${equipo.nombre} con el id: ${equipo.id}');
    var box = await Hive.openBox(kBoxEquipos);
    equipo.save();
    notifyListeners();
  }

  void readTeams({bool force = false}) async {
    var box = await Hive.openBox(kBoxEquipos);
    // Equipo.counter = await box.get(_sizeDataBase, defaultValue: 0);

    // print('Hay ${Equipo.counter} equipos');

    print('box values equipo: ${box.values}');
    if (!_read) {
      if (!_read || force) {
        box.values.forEach((element) {
          print('el equipo ${element.nombre} es creado');
          _equipos.add(element);
        });
        _read = true;
      }

      notifyListeners();
    }
  }

  void deleteTeam(Equipo equipo) async {
    print('eliminando el jugador ${equipo.toString()}');
    // dev.debugger();
    var box = await Hive.openBox(kBoxEquipos);

    equipo.delete();

    _equipos.removeWhere((element) => element.id == equipo.id);
    // _size -= 1;

    notifyListeners();
  }

  void deleteAll() async {
    var box = await Hive.openBox(kBoxJugadores);
    box.deleteFromDisk();
    var box2 = await Hive.openBox(kBoxEquipos);
    box2.deleteFromDisk();
    notifyListeners();
  }

  void closeDB() async {
    var box = await Hive.openBox(kBoxEquipos);
    box.put(_sizeDataBase, Equipo.counter);
  }
}
