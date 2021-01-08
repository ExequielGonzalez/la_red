import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:hive/hive.dart';

import '../constants.dart';

part 'equipo.g.dart';

@HiveType(typeId: 1)
class Equipo {
  @HiveField(0)
  List<Jugador> jugadores;
  @HiveField(1)
  List<Partido> partidosAnteriores;
  @HiveField(2)
  int puntos;
  @HiveField(3)
  int partidosJugados;
  @HiveField(4)
  int golesFavor;
  @HiveField(5)
  int golesContra;
  @HiveField(6)
  int partidosGanados;
  @HiveField(7)
  int partidosPerdidos;
  @HiveField(8)
  int partidosEmpates;
  @HiveField(9)
  String nombre;
  @HiveField(10)
  int id;
  @HiveField(11)
  String photoURL;
  @HiveField(12)
  String liga;

  static int counter = 0;

  Equipo({
    this.puntos,
    this.golesContra,
    this.golesFavor,
    this.partidosEmpates,
    this.partidosGanados,
    this.partidosJugados,
    this.partidosPerdidos,
    this.id,
    this.jugadores,
    this.nombre,
    this.partidosAnteriores,
    this.photoURL,
    this.liga,
  }) {
    this.id = counter;
    counter += 1;
  }

  // Equipo(){
  //   counter+=1;
  //   this.puntos=puntos;
  //   this.golesContra=golesContra;
  //   this.golesFavor=golesFavor;
  //   this.partidosEmpates=partidosEmpates;
  //   this.partidosGanados=partidosGanados;
  //   this.partidosJugados=partidosJugados;
  //   this.partidosPerdidos=partidosPerdidos;
  //   this.id=counter;
  //   this.jugadores=jugadores;
  //   this.nombre=nombre;
  //   this.partidosAnteriores=partidosAnteriores;
  //   this.photoURL=photoURL;
  // };

  Equipo.auto() {
    this.puntos = 16;
    this.golesContra = 10;
    this.golesFavor = 20;
    this.partidosEmpates = 11;
    this.partidosGanados = 12;
    this.partidosJugados = 35;
    this.partidosPerdidos = 12;
    this.id = counter;
    this.jugadores = null;
    this.nombre = 'Boca Juniors';
    this.partidosAnteriores = null;
    this.photoURL = "assets/images/contacto.png";
    this.liga = Leagues.femenino.toString();
    print('Se creo el equipo: ${this.nombre}, con el ID: ${this.id}');
    counter += 1;
  }

  @override
  int get typeId => 1;
}
