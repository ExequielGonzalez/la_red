import 'package:flutter/foundation.dart';

import 'package:la_red/model/equipo.dart';

import 'package:hive/hive.dart';

import '../constants.dart';

class EquipoData with ChangeNotifier {
  List<Equipo> _equipos = [];
  static bool _readed = false;

  List<Equipo> get getEquipos => _equipos;
  Equipo getTeam(index) => _equipos.elementAt(index);
  int get teamLength => _equipos.length;

  void createTeam() async {
    var box = await Hive.openBox(kBoxName);

    Equipo.counter = await box.get('size', defaultValue: 0);
    print(Equipo.counter);
    await box.put('eq${Equipo.counter}', Equipo.auto());
    await box.put('size', Equipo.counter);
    await box.put('eq${Equipo.counter}', Equipo.auto());
    await box.put('size', Equipo.counter);
    notifyListeners();
  }

  void readTeams() async {
    var box = await Hive.openBox(kBoxName);
    Equipo.counter = await box.get('size', defaultValue: 0);

    print('look at thisss ${Equipo.counter}');
    if (!_readed) {
      for (int i = 0; i < Equipo.counter; i++) {
        var aux = await box.get('eq$i');
        _equipos.add(aux);
      }
      _readed = true;
    }
    // Equipo.counter = box.get('size', defaultValue: 0);

    notifyListeners();
    // _equipos.forEach((element) {
    //   print(element.id);
    //   print(element.nombre);
    // });
  }

  void deleteTeams() async {
    var box = await Hive.openBox(kBoxName);
    box.deleteFromDisk();
    notifyListeners();
  }

  void closeDB() async {
    var box = await Hive.openBox(kBoxName);
    box.put('size', Equipo.counter);
  }
}
