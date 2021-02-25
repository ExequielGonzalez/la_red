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

  List<Jugador> getJugadoresSinEquipo(Leagues league) {
    List<Jugador> _aux = [];
    _jugadores.forEach((element) {
      if (!element.hasTeam && element.liga == league.toString())
        _aux.add(element);
    });
    return _aux;
  }

  Jugador getJugadorByDNI(int dni) {
    Jugador aux;
    _jugadores.forEach((element) {
      if (element.dni == dni) aux = element;
    });
    print('retornando el jugador $aux');
    return aux;
  }

  int _size = 0;

  List<Jugador> get getJugadores => _jugadores;
  Jugador getPlayer(index) => _jugadores.elementAt(index);
  int get playerLength => _jugadores.length;

  bool isAlreadyCreated(Jugador jugador) {
    bool alreadyExist = false;
    _jugadores.forEach((element) {
      if (element.dni == jugador.dni) alreadyExist = true;
    });
    return alreadyExist;
  }

  void createPlayer(Jugador jugador, {bool onFirestore = true}) async {
    _jugadores.add(jugador);
    var box = await Hive.openBox<Jugador>(kBoxJugadores);

    await box.add(jugador);
    if (onFirestore && !isAlreadyCreated(jugador)) {
      var boxConfig = await Hive.openBox(kBoxConfig);
      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("jugadores")
          .doc('${jugador.dni}')
          .set(jugador.toJson());

      await firestoreInstance.collection("jugadores").doc('${jugador.dni}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

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

      await firestoreInstance.collection("jugadores").doc('${jugador.dni}').set(
          {'Timestamp': DateTime.now().microsecondsSinceEpoch},
          SetOptions(merge: true));

      await firestoreInstance.collection("config").doc('jugadoresEdited').set(
        {'edited': DateTime.now().microsecondsSinceEpoch},
        SetOptions(merge: true),
      );
    } else {
      Jugador aux =
          _jugadores.singleWhere((element) => element.dni == jugador.dni);
      aux.nombre = jugador.nombre;
      aux.apellido = jugador.apellido;
      aux.liga = jugador.liga;
      aux.amarillas = jugador.amarillas;
      aux.dni = jugador.dni;
      aux.nacimiento = jugador.nacimiento;
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
        // print('el jugador ${element.nombre} es creado');
        _jugadores.add(element);
      });

      _read = true;
    }

    notifyListeners();
    return _jugadores;
  }

  //TODO: Pensar la forma de que cuando elimino un jugador de firebase, luego ese jugador se elimine de los hive de todos los celulares
  //TODO: eliminar del equipo al que pertenece en firebase
  void deletePlayer(Jugador jugador, context) async {
    // var box = await Hive.openBox<Jugador>(kBoxJugadores);

    if (!jugador.hasTeam) {
      await jugador.delete();
      _jugadores.removeWhere((element) => element.id == jugador.id);
      //
      final firestoreInstance = FirebaseFirestore.instance;

      await firestoreInstance
          .collection("jugadores")
          .doc('${jugador.dni}')
          .delete();
      // print('borrando jugador : ${jugador.nombre}');
      //
      // Equipo equipo = Provider.of<EquipoData>(context, listen: false)
      //     .getEquipoByPlayer(jugador);
      //
      // //TODO: ELiminar el jugador
      // print(
      //     'El jugador ${jugador.nombre} juega en el equipo ${equipo.nombre} con el ID: ${equipo.id}');
      //
      // await firestoreInstance
      //     .collection("equipos")
      //     .doc("${equipo.id}")
      //     .set(equipo.toJson(), SetOptions(merge: true));
      _size -= 1;
      notifyListeners();
    }
  }
}
