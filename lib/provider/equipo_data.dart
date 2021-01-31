import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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

  Equipo getEquipoById(String id) {
    Equipo aux;
    // print(id);
    _equipos.forEach((element) {
      // print(element.id);
      if (element.id == id) aux = element;
    });
    // print('retornando el equipo $aux');
    return aux;
  }

  void createTeam(Equipo equipo, {bool onFirestore = true}) async {
    _equipos.add(equipo);
    var box = await Hive.openBox<Equipo>(kBoxEquipos);

    print(
        'creando equipo ${equipo.nombre} con el id: ${equipo.id} y con jugadores ${equipo.jugadores} ');

    box.add(equipo);

    if (onFirestore) {
      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("equipos")
          .doc('${equipo.id}')
          .set(equipo.toJson());

      await firestoreInstance.collection("equipos").doc('${equipo.id}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

      await firestoreInstance.collection("config").doc('equiposEdited').set(
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

    if (equipo.isInBox) {
      await equipo.save();

      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("equipos")
          .doc('${equipo.id}')
          .set(equipo.toJson(), SetOptions(merge: true))
          .then((_) => print('success!: el equipo $equipo fue editado'));

      await firestoreInstance.collection("equipos").doc('${equipo.id}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

      await firestoreInstance.collection("config").doc('equiposEdited').set(
        {'edited': DateTime.now().microsecondsSinceEpoch},
        SetOptions(merge: true),
      );
    } else {
      Equipo aux = _equipos.singleWhere((element) => element.id == equipo.id);
      aux.puntos = equipo.puntos;
      aux.golesContra = equipo.golesContra;
      aux.golesFavor = equipo.golesFavor;
      aux.partidosEmpates = equipo.partidosEmpates;
      aux.partidosGanados = equipo.partidosGanados;
      aux.partidosJugados = equipo.partidosJugados;
      aux.partidosPerdidos = equipo.partidosPerdidos;

      aux.jugadores = equipo.jugadores;
      aux.nombre = equipo.nombre;
      // aux.partidosAnteriores = equipo.partidosAnteriores;
      aux.photoURL = equipo.photoURL;
      aux.liga = equipo.liga;
      aux.save();
    }

    notifyListeners();
  }

  Future<List<Equipo>> readTeams({bool force = false}) async {
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
    }
    notifyListeners();
    return _equipos;
  }

  void deleteTeam(Equipo equipo) async {
    // print('eliminando el equipo ${equipo.toString()}');
    // dev.debugger();
    var box = await Hive.openBox<Equipo>(kBoxEquipos);

    equipo.delete();

    _equipos.removeWhere((element) => element.id == equipo.id);

    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("equipos").doc('${equipo.id}').delete();

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('${equipo.liga}/${equipo.nombre}.text');

    try {
      await ref.delete();
    } catch (e) {
      print(e);
    }

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
