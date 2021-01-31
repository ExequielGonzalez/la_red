import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
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
      await firestoreInstance.collection("jugadores").get().then((value) {
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
                .where("Timestamp", isGreaterThanOrEqualTo: lastRead)
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

  Future<void> readTeamsFirestore() async {
    var boxConfig = await Hive.openBox(kBoxConfig);
    var boxJugadores = await Hive.openBox<Jugador>(kBoxJugadores);
    final equipos = Provider.of<EquipoData>(context, listen: false);
    final jugadores = Provider.of<JugadorData>(context, listen: false);
    final firestoreInstance = FirebaseFirestore.instance;
    var timestamp = DateTime.now().microsecondsSinceEpoch;

    int lastRead = boxConfig.get('lastReadEquipo', defaultValue: -1);

    if (lastRead == -1) {
      ///Nunca fue leída la base de datos
      print("nunca fue leida la base de datos");
      await firestoreInstance.collection("equipos").get().then((value) {
        value.docs.forEach((element) async {
          if (element.exists) {
            //Primero se crea la lista de jugadores que pertenecen al equipo.
            List<Jugador> listPlayers =
                List<Jugador>.from((element.data()["jugadores"].map((item) {
              return Jugador.fromJson(item);
            })));

            //Luego en esta lista auxiliar se toman los jugadores que ya estan
            // en hive que conciden con los jugadores que se leyeron de firestore

            List<Jugador> _temporaryList = [];

            listPlayers.forEach((element) {
              _temporaryList.add(jugadores.getJugadorByDNI(element.dni));
            });
            //se descarga la foto del equipo

            Uint8List foto = await downloadPhoto(
                element.data()["liga"], element.data()["nombre"]);

            //Se crea el equipo con la información de firestore, pero no se le
            //agregan los jugadores
            Equipo aux = Equipo.fromFirestore(element, foto);
            //Se le añaden los jugadores al equipo recien creado.
            aux.jugadores = HiveList(boxJugadores, objects: _temporaryList);

            if (equipos.getEquipos.isEmpty)
              equipos.createTeam(aux, onFirestore: false);
            else if (equipos.getEquipos.isNotEmpty) {
              if (equipos.getEquipos.singleWhere(
                      (element2) => element2.id == aux.id,
                      orElse: () => null) !=
                  null) {
                equipos.editTeam(aux);
              } else
                equipos.createTeam(aux, onFirestore: false);
            }
          }
        });
      });
    } else {
      print("la base de datos de equipos ya fue leída alguna vez");

      ///La base de datos ya fue leída alguna vez, esto implica que la aplicación no es la primera vez que se ejecuta
      int lastEditionDatabase = 0;
      firestoreInstance
          .collection("config")
          .doc("equiposEdited")
          .get()
          .then((value) async {
        if (value.exists) {
          print("Existen equipos en firestore");

          ///Si algun jugador existe en firestore, entra a este condicional
          lastEditionDatabase = value.get('edited');
          if (lastEditionDatabase > lastRead) {
            print('Leyendo información de firebase');
            await firestoreInstance
                .collection("equipos")
                .where("Timestamp", isGreaterThanOrEqualTo: lastRead)
                .get()
                .then((value) {
              value.docs.forEach((element) async {
                if (element.exists) {
                  //Primero se crea la lista de jugadores que pertenecen al equipo.
                  List<Jugador> listPlayers = List<Jugador>.from(
                      (element.data()["jugadores"].map((item) {
                    return Jugador.fromJson(item);
                  })));

                  //Luego en esta lista auxiliar se toman los jugadores que ya estan
                  // en hive que conciden con los jugadores que se leyeron de firestore

                  List<Jugador> _temporaryList = [];

                  listPlayers.forEach((element) {
                    _temporaryList.add(jugadores.getJugadorByDNI(element.dni));
                  });

                  //se descarga la foto del equipo

                  Uint8List foto = await downloadPhoto(
                      element.data()["liga"], element.data()["nombre"]);

                  //Se crea el equipo con la información de firestore, pero no se le
                  //agregan los jugadores
                  Equipo aux = Equipo.fromFirestore(element, foto);
                  //Se le añaden los jugadores al equipo recien creado.
                  aux.jugadores =
                      HiveList(boxJugadores, objects: _temporaryList);

                  if (equipos.getEquipos.isEmpty)
                    equipos.createTeam(aux, onFirestore: false);
                  else if (equipos.getEquipos.isNotEmpty) {
                    if (equipos.getEquipos.singleWhere(
                            (element2) => element2.id == aux.id,
                            orElse: () => null) !=
                        null) {
                      equipos.editTeam(aux);
                    } else
                      equipos.createTeam(aux, onFirestore: false);
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
    await boxConfig.put('lastReadEquipo', timestamp);
  }

  Future<Uint8List> downloadPhoto(String league, String name) async {
    String downloadLink;
    Uint8List downloadedData;
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('$league/$name.text');

    try {
      // Get raw data.
      downloadedData = await ref.getData();

      downloadLink = await ref.getDownloadURL();
      print(downloadLink);
    } catch (e) {
      downloadedData = (await rootBundle.load("assets/images/logo.jpg"))
          .buffer
          .asUint8List();
      print(e);
    }

    return downloadedData;
  }

  Future<void> readMatchesFirestore() async {
    var boxConfig = await Hive.openBox(kBoxConfig);
    var boxEquipos = await Hive.openBox<Equipo>(kBoxEquipos);
    final equipos = Provider.of<EquipoData>(context, listen: false);
    final partidos = Provider.of<PartidoData>(context, listen: false);
    final firestoreInstance = FirebaseFirestore.instance;
    var timestamp = DateTime.now().microsecondsSinceEpoch;
    Uint8List foto =
        (await rootBundle.load("assets/images/logo.jpg")).buffer.asUint8List();
    int lastRead = boxConfig.get('lastReadPartido', defaultValue: -1);

    if (lastRead == -1) {
      ///Nunca fue leída la base de datos
      print("nunca fue leida la base de datos");
      await firestoreInstance.collection("partidos").get().then((value) {
        value.docs.forEach((element) async {
          if (element.exists) {
            //Primero se crean los dos equipos que conforman el partido.
            List<Equipo> equipo1 =
                List<Equipo>.from((element.data()["equipo1"].map((item) {
              return Equipo.fromJson(item);
            })));

            List<Equipo> equipo2 =
                List<Equipo>.from((element.data()["equipo2"].map((item) {
              return Equipo.fromJson(item);
            })));

            //Luego en esta lista auxiliar se toman los equipos que ya estan
            // en hive que conciden con los equipos que se leyeron de firestore

            List<Equipo> _temporaryListEquipo1 = [];
            List<Equipo> _temporaryListEquipo2 = [];

            equipo1.forEach((element1) {
              _temporaryListEquipo1.add(equipos.getEquipoById(element1.id));
            });
            equipo2.forEach((element1) {
              _temporaryListEquipo2.add(equipos.getEquipoById(element1.id));
            });

            print(
                'el equipo 1 es: ${_temporaryListEquipo1.first.nombre} y tiene los jugadores: ${_temporaryListEquipo1.first.jugadores}');
            print(
                'el equipo 2 es: ${_temporaryListEquipo2.first.nombre} y tiene los jugadores: ${_temporaryListEquipo2.first.jugadores}');

            //Se crea el partido con la información de firestore, pero no se le
            //agregan los equipos
            Partido aux = Partido.fromFirestore(element);
            //Se le añaden los jugadores al equipo recien creado.
            aux.equipo1 = HiveList(boxEquipos, objects: _temporaryListEquipo1);
            aux.equipo2 = HiveList(boxEquipos, objects: _temporaryListEquipo2);

            if (partidos.getPartidos.isEmpty)
              partidos.createMatch(aux, onFirestore: false);
            else if (partidos.getPartidos.isNotEmpty) {
              if (partidos.getPartidos.singleWhere(
                      (element2) => element2.id == aux.id,
                      orElse: () => null) !=
                  null) {
                partidos.editMatch(aux);
              } else
                partidos.createMatch(aux, onFirestore: false);
            }
          }
        });
      });
    } else {
      print("la base de datos de partidos ya fue leída alguna vez");

      ///La base de datos ya fue leída alguna vez, esto implica que la aplicación no es la primera vez que se ejecuta
      int lastEditionDatabase = 0;
      firestoreInstance
          .collection("config")
          .doc("partidosEdited")
          .get()
          .then((value) async {
        if (value.exists) {
          print("Existen partidos en firestore");

          ///Si algun partido existe en firestore, entra a este condicional
          lastEditionDatabase = value.get('edited');
          if (lastEditionDatabase > lastRead) {
            print('Leyendo información de firebase');
            await firestoreInstance
                .collection("partidos")
                .where("Timestamp", isGreaterThanOrEqualTo: lastRead)
                .get()
                .then((value) {
              value.docs.forEach((element) {
                if (element.exists) {
                  //Primero se crean los dos equipos que conforman el partido.
                  List<Equipo> equipo1 =
                      List<Equipo>.from((element.data()["equipo1"].map((item) {
                    return Equipo.fromJson(item);
                  })));

                  List<Equipo> equipo2 =
                      List<Equipo>.from((element.data()["equipo2"].map((item) {
                    return Equipo.fromJson(item);
                  })));

                  //Luego en esta lista auxiliar se toman los equipos que ya estan
                  // en hive que conciden con los equipos que se leyeron de firestore

                  List<Equipo> _temporaryListEquipo1 = [];
                  List<Equipo> _temporaryListEquipo2 = [];

                  equipo1.forEach((element1) {
                    _temporaryListEquipo1
                        .add(equipos.getEquipoById(element1.id));
                  });
                  equipo2.forEach((element1) {
                    _temporaryListEquipo2
                        .add(equipos.getEquipoById(element1.id));
                  });

                  print(
                      'el equipo 1 es: ${_temporaryListEquipo1.first.nombre} y tiene los jugadores: ${_temporaryListEquipo1.first.jugadores}');
                  print(
                      'el equipo 2 es: ${_temporaryListEquipo2.first.nombre} y tiene los jugadores: ${_temporaryListEquipo2.first.jugadores}');

                  //Se crea el partido con la información de firestore, pero no se le
                  //agregan los equipos
                  Partido aux = Partido.fromFirestore(element);
                  //Se le añaden los jugadores al equipo recien creado.
                  aux.equipo1 =
                      HiveList(boxEquipos, objects: _temporaryListEquipo1);
                  aux.equipo2 =
                      HiveList(boxEquipos, objects: _temporaryListEquipo2);

                  if (partidos.getPartidos.isEmpty)
                    partidos.createMatch(aux, onFirestore: false);
                  else if (partidos.getPartidos.isNotEmpty) {
                    if (partidos.getPartidos.singleWhere(
                            (element2) => element2.id == aux.id,
                            orElse: () => null) !=
                        null) {
                      partidos.editMatch(aux);
                    } else
                      partidos.createMatch(aux, onFirestore: false);
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
    await boxConfig.put('lastReadPartido', timestamp);
  }

  void readFirestore(bool force) async {
    await Provider.of<JugadorData>(context, listen: false).readPlayers();
    await Firebase.initializeApp();

    if (force) {
      await readPlayersFirestore();
      await readTeamsFirestore();
      await readMatchesFirestore();
    }

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
