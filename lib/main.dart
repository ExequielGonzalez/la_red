import 'package:flutter/material.dart';
import 'package:la_red/screens/contacto.dart';
import 'package:la_red/screens/fixture.dart';
import 'package:la_red/screens/goleadores.dart';
import 'package:la_red/screens/home.dart';
import 'package:la_red/screens/equiposScreen.dart';
import 'package:la_red/screens/instalaciones.dart';
import 'package:la_red/screens/novedades.dart';
import 'package:la_red/screens/posiciones.dart';
import 'package:la_red/screens/reglamento.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
