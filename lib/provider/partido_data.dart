import 'package:cloud_firestore/cloud_firestore.dart';
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
  int _lastKeyEdited;

  List<Partido> get getPartidos => _partidos;
  Partido getMatchByIndex(index) => _partidos.elementAt(index);
  int get nMatches => _partidos.length;
  // int get lastKeyEdited => _lastKeyEdited;
  int get lastKeyEdited => _lastKeyEdited;

  Partido getMatchByKey(key) {
    return _partidos.firstWhere((element) => element.key == key);
  }

  List<Partido> getMatchesByTeam(Equipo equipo) {
    print(
        'en el metodo getMatchesByTeam se recibio el equipo ${equipo.nombre} de la liga ${equipo.liga}, que tiene ${equipo.jugadores.length} jugadores y son: ${equipo.jugadores}');
    List<Partido> _aux = [];
    _partidos.forEach((element) {
      if (element.equipo1.first.id == equipo.id ||
          element.equipo2.first.id == equipo.id) _aux.add(element);
    });
    return _aux;
  }

  void createMatch(Partido partido, {bool onFirestore = true}) async {
    print('Creando partido con hive');
    _partidos.add(partido);
    var box = await Hive.openBox<Partido>(kBoxPartidos);
    box.add(partido);
    if (onFirestore) {
      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("partidos")
          .doc('${partido.id}')
          .set(partido.toJson());

      await firestoreInstance.collection("partidos").doc('${partido.id}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

      await firestoreInstance.collection("config").doc('partidosEdited').set(
        {'edited': DateTime.now().microsecondsSinceEpoch},
        SetOptions(merge: true),
      );
    }
    _lastKeyEdited = partido.key;
    notifyListeners();
  }

  void editMatch(Partido partido) async {
    var box = await Hive.openBox<Partido>(kBoxPartidos);

    if (partido.isInBox) {
      await partido.save();

      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("partidos")
          .doc('${partido.id}')
          .set(partido.toJson(), SetOptions(merge: true))
          .then((_) => print('success!: el partido $partido fue editado'));

      await firestoreInstance.collection("partidos").doc('${partido.id}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

      await firestoreInstance.collection("config").doc('partidosEdited').set(
        {'edited': DateTime.now().microsecondsSinceEpoch},
        SetOptions(merge: true),
      );
    } else {
      Partido aux =
          _partidos.singleWhere((element) => element.id == partido.id);
      aux.equipo1 = partido.equipo1;
      aux.equipo2 = partido.equipo2;
      aux.liga = partido.liga;
      aux.isFinished = partido.isFinished;
      aux.golE1 = partido.golE1;
      aux.golE2 = partido.golE2;
      aux.numCancha = partido.numCancha;
      aux.fecha = partido.fecha;
      aux.save();
    }

    _lastKeyEdited = partido.key;
    notifyListeners();
  }

  Future<List<Partido>> readMatches() async {
    var box = await Hive.openBox<Partido>(kBoxPartidos);
    print('box values partidos: ${box.values}');

    if (!_read) {
      box.values.forEach((element) {
        print(
            'el partido entre ${element.equipo1.first.nombre} vs ${element.equipo2.first.nombre} es creado');
        _partidos.add(element);
      });
      _read = true;
    }

    notifyListeners();
    return _partidos;
  }

  void deleteMatch(Partido partido) async {
    var box = await Hive.openBox<Partido>(kBoxPartidos);
    partido.delete();
    _lastKeyEdited = partido.key;
    _partidos.removeWhere((element) => element.id == partido.id);

    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("partidos")
        .doc('${partido.id}')
        .delete();

    notifyListeners();
  }
}
