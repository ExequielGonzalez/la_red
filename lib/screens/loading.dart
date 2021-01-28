import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/partido_data.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    readFirestore(!kRestart);
    super.initState();
  }

  Future<void> readPlayersFirestore() async {
    var boxConfig = await Hive.openBox(kBoxConfig);
    final jugadores = Provider.of<JugadorData>(context, listen: false);
    final firestoreInstance = FirebaseFirestore.instance;
    var timestamp = DateTime.now().microsecondsSinceEpoch;
    int lastRead = boxConfig.get('lastReadJugador', defaultValue: -1);

    if (lastRead == -1) {
      ///Nunca fue leída la base de datos
      print("nunca fue leida la base de datos");
      await firestoreInstance
          .collection("jugadores")
          .where("Timestamp", isLessThanOrEqualTo: timestamp)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          if (element.exists) {
            print(element.data());
            Jugador aux = Jugador.fromFirestore(element);
            if (jugadores.getJugadores.isEmpty)
              jugadores.createPlayer(aux, onFirestore: false);
            else if (jugadores.getJugadores.isNotEmpty) {
              if (jugadores.getJugadores.singleWhere(
                      (element2) => element2.dni == aux.dni,
                      orElse: () => null) !=
                  null) {
                jugadores.editPlayer(aux);
              } else
                jugadores.createPlayer(aux, onFirestore: false);
            }
          }
        });
      });
    } else {
      print("la base de datos ya fue leída alguna vez");

      ///La base de datos ya fue leída alguna vez, esto implica que la aplicación no es la primera vez que se ejecuta
      int lastEditionDatabase = 0;
      firestoreInstance
          .collection("config")
          .doc("jugadoresEdited")
          .get()
          .then((value) async {
        if (value.exists) {
          print("Existen jugadores en firestore");

          ///Si algun jugador existe en firestore, entra a este condicional
          lastEditionDatabase = value.get('edited');
          if (lastEditionDatabase > lastRead) {
            print('Leyendo información de firebase');
            await firestoreInstance
                .collection("jugadores")
                .where("Timestamp", isLessThanOrEqualTo: timestamp)
                .get()
                .then((value) {
              value.docs.forEach((element) {
                if (element.exists) {
                  print(element.data());
                  Jugador aux = Jugador.fromFirestore(element);
                  if (jugadores.getJugadores.isEmpty)
                    jugadores.createPlayer(aux, onFirestore: false);
                  else if (jugadores.getJugadores.isNotEmpty) {
                    if (jugadores.getJugadores.singleWhere(
                            (element2) => element2.dni == aux.dni,
                            orElse: () => null) !=
                        null) {
                      jugadores.editPlayer(aux);
                    } else
                      jugadores.createPlayer(aux, onFirestore: false);
                  }
                }
              });
            });
          } else
            print('No es necesario leer firestore. Se usa hive de cache');
        } else
          print('Nada para leer en firestore');
      });
    }
    await boxConfig.put('lastReadJugador', timestamp);
  }

  Future<void> readTeamsFirestore() {}

  void readFirestore(bool force) async {
    await Provider.of<JugadorData>(context, listen: false).readPlayers();
    await Firebase.initializeApp();
    await readPlayersFirestore();
    await readTeamsFirestore();

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<JugadorData>(context, listen: false).readPlayers();
    Provider.of<EquipoData>(context, listen: false).readTeams();
    Provider.of<PartidoData>(context, listen: false).readMatches();

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
