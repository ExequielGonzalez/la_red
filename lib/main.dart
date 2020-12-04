import 'package:flutter/material.dart';
import 'package:la_red/screens/home.dart';
import 'package:la_red/screens/equipos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      title: 'La Red',
      initialRoute: '/equipos',
      routes: {
        '/': (context) => Home(),
        '/equipos': (context) => Equipos(),
      },
    );
  }
}
