import 'package:flutter/cupertino.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';

class Equipo {
  List<Jugador> jugadores;
  List<Partido> partidosAnteriores;

  int puntos;
  int partidosJugados;
  int golesFavor;
  int golesContra;
  int victorias;
  int derrotas;
  int empates;
  String nombre;
  int id;
}
