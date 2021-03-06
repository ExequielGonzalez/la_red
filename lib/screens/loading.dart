import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';
import 'package:hive/hive.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/model/equipo.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/partido_data.dart';
import 'package:la_red/widgets/background.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

import 'dart:io';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();

    startFirebase();
  }

  Future<bool> checkInternet() async {
    bool connection = false;
    try {
      final result = await InternetAddress.lookup('google.com.ar');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print(
            '----------------------------------------connected-----------------------------------------------');
        connection = true;
      }
    } on SocketException catch (_) {
      connection = false;
      print(
          '----------------------------------------------------not connected------------------------------------');
    }
    return connection;
  }

  void startFirebase() async {
    bool connection =
        await checkInternet(); //Si hay conexión a internet, se lee firestore. Si no, se sigue con lo que ya hay en hive
    if (connection) {
      await Firebase.initializeApp();

      ///Esto es para provocar un reset en todos los celulares.
      // await cleanDataBase(reset: true, hardReset: false);

      checkCleanDataBase().then((value) {
        setState(() {
          progress = 0.20;
        });
        print('Ya se limpio la base de datos : $value');
        readFirestore(!kRestart);
      });
    } else {
      await Provider.of<JugadorData>(context, listen: false).readPlayers();
      await Provider.of<EquipoData>(context, listen: false).readTeams();
      await Provider.of<PartidoData>(context, listen: false).readMatches();

      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<bool> checkCleanDataBase() async {
    bool continueReading = false;
    //Primero se chequea la última lectura a la DB. Si es la primera vez que se abre la aplicación, entonces no hay que borrar nada y se retorna -1.
    var boxConfig = await Hive.openBox(kBoxConfig);
    int lastRead = await boxConfig.get('lastReadClean', defaultValue: -1);
    if (lastRead != -1) {
      //TODO: ESTO no sirve porque lastReadVersion solo funciona una vez. Hay que ligarlo de alguna manera a firebase
      String projectCode;
// Platform messages may fail, so we use a try/catch PlatformException.
      try {
        projectCode = await GetVersion.projectCode;
        print('code version: $projectCode');
      } on PlatformException {
        projectCode = '0';
      }
      int lastReadVersion =
          await boxConfig.get('lastReadVersion', defaultValue: -1);
      if (projectCode == '4' && lastReadVersion == -1) {
        var boxJugadores = await Hive.openBox<Jugador>(
          kBoxJugadores,
        );
        var boxEquipos = await Hive.openBox<Equipo>(
          kBoxEquipos,
        );
        var boxPartidos = await Hive.openBox<Partido>(
          kBoxPartidos,
        );
        boxJugadores.clear();
        boxEquipos.clear();
        boxPartidos.clear();
        await boxConfig.put('lastReadJugador', -1);
        await boxConfig.put('lastReadEquipo', -1);
        await boxConfig.put('lastReadPartido', -1);

        var timestamp = DateTime.now().microsecondsSinceEpoch;
        await boxConfig.put('lastReadVersion',
            timestamp); //se guarda la última vez que se chequeo esto.
      }

      //Si es distinto de -1, implica que no es la primera vez que se abre la base de datos
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance
          .collection("config")
          .doc("clean_database")
          .get()
          .then((value) async {
        if (value.exists) {
          int lastEditionDatabase = value.get(
              'edited'); //se revisa cuando fue la ultima vez que se modificó la base de datos
          if (lastEditionDatabase > lastRead) {
            // corresponde limpiar Hive
            bool softReset = value.get('reset');
            bool hardReset = value.get('hard_reset');
            print(
                '\n\n\n\nhay que hacer soft reset: $softReset.\n Hay que hacer hard reset: $hardReset');
            if (softReset) {
              var boxJugadores = await Hive.openBox<Jugador>(
                kBoxJugadores,
              );
              var boxEquipos = await Hive.openBox<Equipo>(
                kBoxEquipos,
              );
              var boxPartidos = await Hive.openBox<Partido>(
                kBoxPartidos,
              );
              boxJugadores.clear();
              boxEquipos.clear();
              boxPartidos.clear();
              await boxConfig.put('lastReadJugador', -1);
              await boxConfig.put('lastReadEquipo', -1);
              await boxConfig.put('lastReadPartido', -1);
              continueReading = true;
            }
          }
        }
      });
    }
    var timestamp = DateTime.now().microsecondsSinceEpoch;
    await boxConfig.put('lastReadClean',
        timestamp); //se guarda la última vez que se chequeo esto.
    return continueReading;
  }

  Future<void> readFirestore(bool force) async {
    await Provider.of<JugadorData>(context, listen: false).readPlayers();
    await Provider.of<EquipoData>(context, listen: false).readTeams();
    await Provider.of<PartidoData>(context, listen: false).readMatches();

    if (force) {
      readPlayersFirestore().then((_) {
        setState(() {
          progress = 0.40;
        });
        readTeamsFirestore().then((_) {
          setState(() {
            progress = 0.60;
          });

          updateTeamPhotos().then((_) {
            setState(() {
              progress = 0.80;
            });
            readMatchesFirestore().then((value) {
              setState(() {
                progress = 1;
              });
              Navigator.pushReplacementNamed(context, '/home');
            });
          });
        });
      });
    }
  }

  Future<void> cleanDataBase({bool reset, bool hardReset = false}) async {
    final firestoreInstance = FirebaseFirestore.instance;
    await firestoreInstance.collection("config").doc('clean_database').set(
      {
        'edited': DateTime.now().microsecondsSinceEpoch,
        'reset': reset,
        'hard_reset': hardReset,
      },
      SetOptions(merge: true),
    );
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
            print(
                'No es necesario leer firestore. Se usa hive de cache para jugadores');
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

    int lastRead = await boxConfig.get('lastReadEquipo', defaultValue: -1);

    if (lastRead == -1) {
      ///Nunca fue leída la base de datos
      print("nunca fue leida la base de datos");
      await firestoreInstance.collection("equipos").get().then((value) {
        value.docs.forEach((element) async {
          if (element.exists) {
            print(
                'leyendo el equipo: ${element.data()["nombre"]} con la ID: ${element.data()["id"]}');

            //Primero se crea la lista de jugadores que pertenecen al equipo.
            List<Jugador> listPlayers =
                List<Jugador>.from((element.data()["jugadores"].map((item) {
              return Jugador.fromJson(item);
            })));

            //TODO: BORRAR
            if (element.data()["id"] == "ABUELO Y ROBERTOLeagues.libre") {
              print('----------Acá esta---------');
              print(listPlayers.length);
              print(listPlayers);
            }

            //Luego en esta lista auxiliar se toman los jugadores que ya estan
            // en hive que conciden con los jugadores que se leyeron de firestore

            List<Jugador> _temporaryList = [];

            listPlayers.forEach((element) {
              _temporaryList.add(jugadores.getJugadorByDNI(element.dni));
            });
            //TODO: BORRAR
            if (element.data()["id"] == "ABUELO Y ROBERTOLeagues.libre") {
              print('----------Acá esta---------');
              print(_temporaryList.length);
              print(_temporaryList);
            }

            //Se crea el equipo con la información de firestore, pero no se le
            //agregan los jugadores
            Equipo aux = Equipo.fromFirestore(element);
            // dev.debugger();
            //Se le añaden los jugadores al equipo recien creado.
            aux.jugadores = HiveList(boxJugadores, objects: _temporaryList);

            if (equipos.getEquipos.isEmpty)
              equipos.createTeam(aux, onFirestore: false);
            else if (equipos.getEquipos.isNotEmpty) {
              bool isAlreadyCreated = false;
              equipos.getEquipos.forEach((element2) {
                if (element2.id == aux.id) {
                  isAlreadyCreated = true;
                  // print('editando el equipo ${aux.nombre}');
                  equipos.editTeam(aux);
                }
              });
              if (!isAlreadyCreated) {
                print('Añadiendo el equipo ${aux.nombre} a la base de datos');
                equipos.createTeam(aux, onFirestore: false);
              }
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
                  print(
                      'Creando en el arranque el equipo ${element.data()["id"]}');
                  //Se crea el equipo con la información de firestore, pero no se le
                  //agregan los jugadores
                  Equipo aux = Equipo.fromFirestore(element);
                  //Se le añaden los jugadores al equipo recien creado.
                  aux.jugadores =
                      HiveList(boxJugadores, objects: _temporaryList);

                  if (equipos.getEquipos.isEmpty)
                    equipos.createTeam(aux, onFirestore: false);
                  else if (equipos.getEquipos.isNotEmpty) {
                    bool isAlreadyCreated = false;
                    equipos.getEquipos.forEach((element2) {
                      if (element2.id == aux.id) {
                        isAlreadyCreated = true;
                        // print('editando el equipo ${aux.nombre}');
                        equipos.editTeam(aux);
                      } else {
                        print(
                            'El equipo ${element2.nombre} no es el equipo ${aux.nombre}');
                      }
                    });
                    if (!isAlreadyCreated) {
                      // print(
                      //     'Añadiendo el equipo ${aux.nombre} a la base de datos');
                      equipos.createTeam(aux, onFirestore: false);
                      aux.photoURL = await downloadPhoto(aux.liga, aux.nombre);
                      aux.save();
                    }
                  }
                }
              });
            });
          } else
            print(
                'No es necesario leer firestore. Se usa hive de cache para equipos');
        } else
          print('Nada para leer en firestore');
      });
    }
    await boxConfig.put('lastReadEquipo', timestamp);
  }

  Future<Uint8List> downloadPhoto(String league, String name) async {
    // String downloadLink;
    Uint8List downloadedData;
    // print('buscando: $league/$name.text');
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref('$league/$name.text');

    try {
      // Get raw data.
      downloadedData = await ref.getData();
      // downloadLink = await ref.getDownloadURL();
      // print(downloadLink);
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
    // dev.debugger();
    await equipos.readTeams(force: true);
    final firestoreInstance = FirebaseFirestore.instance;
    var timestamp = DateTime.now().microsecondsSinceEpoch;

    int lastRead = await boxConfig.get('lastReadPartido', defaultValue: -1);

    if (lastRead == -1) {
      ///Nunca fue leída la base de datos
      print("nunca fue leida la base de datos");

      if (equipos.getEquipos.isNotEmpty) {
        await firestoreInstance.collection("partidos").get().then((value) {
          value.docs.forEach((element) async {
            if (element.exists) {
              print(element.data()["equipo1"]);
              print(element.data()["equipo2"]);

              //TODO: BORRAR
              if (element.data()["id"] == "2021-02-27-0-0-Leagues.libre-3") {
                print('----------Acá esta el bendito partido---------');
                print('${element.data()["fecha"]}');
              }

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
                // print('buscando ${element1.id}');
                _temporaryListEquipo1.add(equipos.getEquipoById(element1.id));
              });
              equipo2.forEach((element1) {
                // print('buscando ${element1.id}');
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
              aux.equipo1 =
                  HiveList(boxEquipos, objects: _temporaryListEquipo1);
              aux.equipo2 =
                  HiveList(boxEquipos, objects: _temporaryListEquipo2);

              if (partidos.getPartidos.isEmpty)
                partidos.createMatch(aux, onFirestore: false);
              else if (partidos.getPartidos.isNotEmpty) {
                bool isAlreadyCreated = false;
                partidos.getPartidos.forEach((element2) {
                  if (element2.id == aux.id) {
                    isAlreadyCreated = true;
                    // print('lo nuevo: ${aux.id}');
                    // print('lo viejo: ${element2.id}');
                    // print(
                    //     'editando el partido  ${element2.equipo1.first.nombre} vs ${element2.equipo2.first.nombre} que antes era ${aux.equipo1.first.nombre} vs ${aux.equipo2.first.nombre}');
                    partidos.editMatch(aux);
                    // print('lo nuevo: ${aux.id}');
                    // print('lo viejo: ${element2.id}');
                  } else {
                    // print(
                    //     'El partido ${element2.equipo1.first.nombre} vs ${element2.equipo2.first.nombre} no es el partido ${aux.equipo1.first.nombre} vs ${aux.equipo2.first.nombre}');
                  }
                });
                if (!isAlreadyCreated) {
                  print(
                      'Añadiendo el partido ${aux.equipo1.first.nombre} vs ${aux.equipo2.first.nombre} a la base de datos');
                  partidos.createMatch(aux, onFirestore: false);
                }
                // if (partidos.getPartidos.singleWhere(
                //         (element2) => element2.id == aux.id,
                //         orElse: () => null) !=
                //     null) {
                //   partidos.editMatch(aux);
                // } else
                //   partidos.createMatch(aux, onFirestore: false);

              }
            }
          });
        });
      }
      print('No hay equipos sooo, no hay partidoss');
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

                  // print(
                  //     'el equipo 1 es: ${_temporaryListEquipo1.first.nombre} y tiene los jugadores: ${_temporaryListEquipo1.first.jugadores}');
                  // print(
                  //     'el equipo 2 es: ${_temporaryListEquipo2.first.nombre} y tiene los jugadores: ${_temporaryListEquipo2.first.jugadores}');

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
            print(
                'No es necesario leer firestore. Se usa hive de cache para partidos');
        } else
          print('Nada para leer en firestore');
      });
    }
    await boxConfig.put('lastReadPartido', timestamp);
  }

  Future<void> updateTeamPhotos() async {
    final equiposProvider = Provider.of<EquipoData>(context, listen: false);
    List<Equipo> _equipos = equiposProvider.getEquipos;

    _equipos.forEach((element) async {
      if (element.photoURL == null) {
        Uint8List _aux;
        _aux = await downloadPhoto(element.liga, element.nombre);
        element.photoURL = _aux;

        element.save();
      }
    });
  }

  double width;
  double height;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    // Provider.of<JugadorData>(context, listen: false).readPlayers();
    //   Provider.of<EquipoData>(context, listen: false).readTeams();
    //   Provider.of<PartidoData>(context, listen: false).readMatches();
    SizeConfig().init(context);
    width = SizeConfig.safeBlockHorizontal;
    height = SizeConfig.blockSizeVertical;

    return Scaffold(
      backgroundColor: kBordo,
      body: Stack(
        children: [
          Background(),
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/logo_principal.png",
                    width: width * (0.65),
                    // height: getWidth(0.375),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  'Cargando...',
                  style: kTextStyleBold.copyWith(fontSize: width * 0.075),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(kBordo),
                  value: progress,
                  strokeWidth: 6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
