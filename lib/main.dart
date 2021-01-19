import 'dart:io';
import 'package:flutter/material.dart';

import 'package:la_red/constants.dart';
import 'package:la_red/provider/equipo_data.dart';
import 'package:la_red/provider/jugador_data.dart';
import 'package:la_red/provider/leagues_provider.dart';
import 'package:la_red/provider/partido_data.dart';
import 'package:la_red/screens/contacto.dart';
import 'package:la_red/screens/equipos_screen.dart';
import 'package:la_red/screens/fixture.dart';
import 'package:la_red/screens/goleadores.dart';
import 'package:la_red/screens/home.dart';
import 'package:la_red/screens/instalaciones.dart';
import 'package:la_red/screens/novedades.dart';
import 'package:la_red/screens/posiciones.dart';
import 'package:la_red/screens/reglamento.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:provider/provider.dart';

import 'model/equipo.dart';
import 'model/jugador.dart';
import 'model/partido.dart';

import 'dart:developer' as dev;

Future<List<Box>> _openBox() async {
  List<Box> boxList = [];
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(EquipoAdapter());
  Hive.registerAdapter(PartidoAdapter());
  Hive.registerAdapter(JugadorAdapter());

  var box_jugadores = await Hive.openBox(kBoxJugadores,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  var box_equipos = await Hive.openBox(kBoxEquipos,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });
  var box_partidos = await Hive.openBox(kBoxPartidos,
      compactionStrategy: (entries, deletedEntries) {
    return deletedEntries > 10;
  });

  if (kRestart) {
    box_jugadores.clear();
    box_equipos.clear();
    box_partidos.clear();
  }

  boxList.add(box_jugadores);
  boxList.add(box_partidos);
  boxList.add(box_equipos);

  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  // Hive.init(directory.path);
  // //
  // Hive.registerAdapter(EquipoAdapter());
  // Hive.registerAdapter(PartidoAdapter());
  // Hive.registerAdapter(JugadorAdapter());
  List<Box> boxList = [];
  boxList = await _openBox();

  // final Box<dynamic> dbEquipo = await Hive.openBox(kBoxName,
  //     compactionStrategy: (entries, deletedEntries) {
  //   return deletedEntries > 10;
  // });

  // runApp(MyApp(database: dbEquipo));
  runApp(MyApp(database: boxList));
}

class MyApp extends StatelessWidget {
  // final Box<dynamic> database;
  // MyApp({this.database});
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        title: 'La Red',
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
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
