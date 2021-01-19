import 'dart:typed_data';

import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:hive/hive.dart';

import '../constants.dart';

part 'equipo.g.dart';

@HiveType(typeId: 1)
class Equipo extends HiveObject {
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
  Uint8List photoURL;
  @HiveField(12)
  String liga;
  @HiveField(13)
  int posicion;

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
    this.posicion,
  }) {
    this.id = counter;
    counter += 1;
    print(
        'Constructor de Equipo: Creando equipo ${this.nombre} con id: ${this.id}. El counter vale $counter. key: ${this.key}');
  }

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
    // this.photoURL = "assets/images/contacto.png";
    this.liga = Leagues.femenino.toString();
    this.posicion = 23;
    print('Se creo el equipo: ${this.nombre}, con el ID: ${this.id}');
    counter += 1;
  }

  Equipo.autoNameLeague(name, league) {
    this.puntos = 16;
    this.golesContra = 10;
    this.golesFavor = 20;
    this.partidosEmpates = 11;
    this.partidosGanados = 12;
    this.partidosJugados = 35;
    this.partidosPerdidos = 12;
    this.id = counter;
    this.jugadores = null;
    this.nombre = name;
    this.partidosAnteriores = null;
    // this.photoURL = "assets/images/contacto.png";
    this.liga = league.toString();
    this.posicion = counter + 1;
    print('Se creo el equipo: ${this.nombre}, con el ID: ${this.id}');
    counter += 1;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: ${this.id}  - counter: $counter - key: ${this.key}-> El equipo ${this.nombre} , que juega en la liga ${this.liga} y tiene ${this.puntos} puntos';
  }

  @override
  int get typeId => 1;

  static int sortTeams(b, a) {
    // TODO: implement compareTo
    // return this.puntos.compareTo(other.puntos);
    var sortByPuntos = a.puntos.compareTo(b.puntos);
    if (sortByPuntos != 0)
      return sortByPuntos;
    else
      return a.golesFavor.compareTo(b.golesFavor);
  }

  // if (this.puntos < other.puntos) {
  //   return -1;
  // } else if (this.puntos > other.puntos) {
  //   return 1;
  // } else {
  //   if (this.golesFavor < other.golesFavor) {
  //     return -1;
  //   } else if (this.golesFavor > other.golesFavor) {
  //     return 1;
  //   } else {
  //     //TODO: Implementar que va primero el que haya ganado el partido entre ellos
  //     return 0;
  //   }
  // }

  // @override
  // int compareTo(other) {
  //   // TODO: implement compareTo
  //   // return this.puntos.compareTo(other.puntos);
  //   if (this.puntos < other.puntos) {
  //     return -1;
  //   } else if (this.puntos > other.puntos) {
  //     return 1;
  //   } else {
  //     if (this.golesFavor < other.golesFavor) {
  //       return -1;
  //     } else if (this.golesFavor > other.golesFavor) {
  //       return 1;
  //     } else {
  //       //TODO: Implementar que va primero el que haya ganado el partido entre ellos
  //       return 0;
  //     }
  //   }
  // }
}
