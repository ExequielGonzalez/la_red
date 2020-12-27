import 'package:flutter/cupertino.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';

class Equipo {
  Equipo(
      {this.puntos,
      this.golesContra,
      this.golesFavor,
      this.partidosEmpates,
      this.partidosGanados,
      this.partidosJugados,
      this.partidosPerdidos,
      this.id,
      this.jugadores,
      this.nombre,
      this.partidosAnteriores});
  List<Jugador> jugadores;
  List<Partido> partidosAnteriores;

  int puntos;
  int partidosJugados;
  int golesFavor;
  int golesContra;
  int partidosGanados;
  int partidosPerdidos;
  int partidosEmpates;
  String nombre;
  int id;
}
