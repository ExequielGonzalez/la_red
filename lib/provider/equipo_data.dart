import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:la_red/model/equipo.dart';

import 'package:hive/hive.dart';
import 'package:la_red/model/jugador.dart';

import '../constants.dart';

class EquipoData with ChangeNotifier {
  List<Equipo> _equipos = [];
  static bool _read = false;
  final String _sizeDataBase = 'size';
  final String _identifierDataBase = 'eq';

  List<Equipo> get getEquipos => _equipos;
  Equipo getTeam(index) => _equipos.elementAt(index);
  int get teamLength => _equipos.length;

  void createTeam(Equipo equipo, {bool onFirestore = true}) async {
    _equipos.add(equipo);
    var box = await Hive.openBox<Equipo>(kBoxEquipos);

    print(
        'creando equipo ${equipo.nombre} con el id: ${equipo.id} y con jugadores ${equipo.jugadores} ');

    box.add(equipo);

    if (onFirestore) {
      var boxConfig = await Hive.openBox(kBoxConfig);
      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("equipos")
          .doc('${equipo.nombre}')
          .set(jugador.toJson());

      await firestoreInstance.collection("jugadores").doc('${jugador.dni}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

      await firestoreInstance.collection("config").doc('jugadoresEdited').set(
        {'edited': DateTime.now().microsecondsSinceEpoch},
        SetOptions(merge: true),
      );
    }

    notifyListeners();
  }

  void editTeam(Equipo equipo) async {
    print('editando el equipo: ${equipo.toString()}');
    print(
        'editando el equipo: ${equipo.nombre} con el id: ${equipo.id} y con los jugadores ${equipo.jugadores}');
    var box = await Hive.openBox<Equipo>(kBoxEquipos);
    equipo.save();
    notifyListeners();
  }

  void readTeams({bool force = false}) async {
    var box = await Hive.openBox<Equipo>(kBoxEquipos);

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
    print('eliminando el equipo ${equipo.toString()}');
    // dev.debugger();
    var box = await Hive.openBox<Equipo>(kBoxEquipos);

    equipo.delete();

    _equipos.removeWhere((element) => element.id == equipo.id);

    notifyListeners();
  }

  void deleteAll() async {
    var box = await Hive.openBox<Jugador>(kBoxJugadores);
    box.deleteFromDisk();
    var box2 = await Hive.openBox<Equipo>(kBoxEquipos);
    box2.deleteFromDisk();
    notifyListeners();
  }
}
