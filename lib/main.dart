import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:la_red/constants.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/jugadores_equipo_provider.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/provider/partido_data.dart';
import 'package:la_red/screens/contacto.dart';
import 'package:la_red/screens/equipos_screen.dart';
import 'package:la_red/screens/fixture.dart';
import 'package:la_red/screens/goleadores.dart';
import 'package:la_red/screens/home.dart';
import 'package:la_red/screens/instalaciones.dart';
import 'package:la_red/screens/loading.dart';
import 'package:la_red/screens/novedades.dart';
import 'package:la_red/screens/posiciones.dart';
import 'package:la_red/screens/reglamento.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

import 'model/equipo.dart';
import 'model/jugador.dart';
import 'model/partido.dart';

Future<List<Box>> _openBox() async {
  List<Box> boxList = [];
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  print(directory.path);

  Hive.registerAdapter(EquipoAdapter());
  Hive.registerAdapter(PartidoAdapter());
  Hive.registerAdapter(JugadorAdapter());

  var boxJugadores = await Hive.openBox<Jugador>(kBoxJugadores,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  var boxEquipos = await Hive.openBox<Equipo>(kBoxEquipos,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  var boxPartidos = await Hive.openBox<Partido>(kBoxPartidos,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  var boxConfig = await Hive.openBox(kBoxConfig,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });

  if (kRestart) {
    // boxJugadores.deleteFromDisk();
    // boxConfig.deleteFromDisk();
    // boxPartidos.deleteFromDisk();
    // boxConfig.deleteFromDisk();
    boxJugadores.clear();
    boxEquipos.clear();
    boxPartidos.clear();
    boxConfig.clear();
  }

  boxList.add(boxJugadores);
  boxList.add(boxPartidos);
  boxList.add(boxEquipos);
  boxList.add(boxConfig);

  return boxList;
}

// void startFirebase() async => await Firebase.initializeApp();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await startFirebase();
  List<Box> boxList = [];
  boxList = await _openBox();

  // await readFirestore();
  runApp(MyApp(database: boxList));
}

class MyApp extends StatelessWidget {
  final List<Box> database;
  MyApp({this.database});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LeaguesProvider()),
        ChangeNotifierProvider(create: (_) => EquipoData()),
        ChangeNotifierProvider(create: (_) => PartidoData()),
        ChangeNotifierProvider(create: (_) => JugadorData()),
        ChangeNotifierProvider(create: (_) => JugadoresEquipo())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        title: 'La Red',
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          // '/': (context) => Home(),
          '/home': (context) => Home(),
          '/equipos': (context) => Equipos(),
          '/fixture': (context) => Fixture(),
          '/posiciones': (context) => Posiciones(),
          '/goleadores': (context) => Goleadores(),
          '/instalaciones': (context) => Instalaciones(),
          '/contacto': (context) => Contacto(),
          '/reglamento': (context) => Reglamento(),
          '/novedades': (context) => Novedades(),
        },
      ),
    );
  }
}
