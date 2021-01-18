import 'package:flutter/material.dart';

bool kAdmin = true;
// bool kRestart = true;
bool kRestart = false;
//
enum Leagues { libre, m30, m40, femenino }

String kBoxName = "Equipos";
String kBoxJugadores = "box_jugadores";
String kBoxEquipos = "box_equipos";
String kBoxPartidos = "box_partidos";

Color kBordo = Color(0xFF601A24);

TextStyle kTextStyleBold = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 60,
);

TextStyle kTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 40,
);

double kFontSize;

//flutter packages pub run build_runner build --delete-conflicting-outputs
