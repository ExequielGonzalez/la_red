import 'package:cloud_firestore/cloud_firestore.dart';
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

  List<Jugador> getJugadoresSinEquipo() {
    List<Jugador> _aux = [];
    _jugadores.forEach((element) {
      if (!element.hasTeam) _aux.add(element);
    });
    return _aux;
  }

  int _size = 0;

  List<Jugador> get getJugadores => _jugadores;
  Jugador getPlayer(index) => _jugadores.elementAt(index);
  int get playerLength => _jugadores.length;

  void createPlayer(Jugador jugador, {bool onFirestore = true}) async {
    jugador.keyDataBase = '$_identifierDataBase$_size';
    _jugadores.add(jugador);
    var box = await Hive.openBox<Jugador>(kBoxJugadores);

    // print(
    //     'creando jugador ${jugador.nombre} con el id: ${jugador.id} y n: ${_size}}');

    await box.add(jugador);
    if (onFirestore) {
      var boxConfig = await Hive.openBox(kBoxConfig);
      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("jugadores")
          .doc('${jugador.dni}')
          .set(jugador.toJson());

      await firestoreInstance.collection("jugadores").doc('${jugador.dni}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

      // await boxConfig.put(
      //     'jugadoresEdited', DateTime.now().microsecondsSinceEpoch);
      await firestoreInstance.collection("config").doc('jugadoresEdited').set(
        {'edited': DateTime.now().microsecondsSinceEpoch},
        SetOptions(merge: true),
      );
    }
    _size += 1;
    notifyListeners();
  }

  void editPlayer(Jugador jugador) async {
    // print('editando el jugador: ${jugador.toString()}');
    // print('editando el jugador: ${jugador.nombre} con el id: ${jugador.id}');
    var box = await Hive.openBox<Jugador>(kBoxJugadores);
    if (jugador.isInBox) {
      await jugador.save();

      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("jugadores")
          .doc('${jugador.dni}')
          .set(jugador.toJson(), SetOptions(merge: true))
          .then((_) => print('success!: el jugador $jugador fue editado'));
    } else {
      Jugador aux =
          _jugadores.singleWhere((element) => element.dni == jugador.dni);
      aux.nombre = jugador.nombre;
      aux.apellido = jugador.apellido;
      aux.liga = jugador.liga;
      aux.amarillas = jugador.amarillas;
      aux.dni = jugador.dni;
      aux.edad = jugador.edad;
      aux.goles = jugador.goles;
      aux.rojas = jugador.rojas;
      aux.hasTeam = jugador.hasTeam;

      aux.save();
    }

    notifyListeners();
  }

  Future<List<Jugador>> readPlayers({bool force = false}) async {
    var box = await Hive.openBox<Jugador>(kBoxJugadores);

    // print('box values jugador: ${box.values}');

    if (!_read || force) {
      box.values.forEach((element) {
        print('el jugador ${element.nombre} es creado');
        _jugadores.add(element);
      });

      _read = true;
    }

    notifyListeners();
    return _jugadores;
  }

  void deletePlayer(Jugador jugador) async {
    print('eliminando el jugador ${jugador.toString()}');
    // dev.debugger();
    var box = await Hive.openBox<Jugador>(kBoxJugadores);

    await jugador.delete();

    _jugadores.removeWhere((element) => element.id == jugador.id);

    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance
        .collection("jugadores")
        .doc('${jugador.dni}')
        .delete();

    _size -= 1;

    notifyListeners();
  }
}
