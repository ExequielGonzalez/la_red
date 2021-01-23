import 'package:la_red/model/equipo.dart';
import 'package:hive/hive.dart';

import '../constants.dart';

part 'partido.g.dart';

@HiveType(typeId: 2)
class Partido extends HiveObject {
  @HiveField(0)
  HiveList<Equipo> equipo1;
  @HiveField(1)
  HiveList<Equipo> equipo2;
  @HiveField(2)
  int numCancha;
  @HiveField(3)
  DateTime fecha;
  @HiveField(4)
  String hora;
  @HiveField(5)
  int golE1;
  @HiveField(6)
  int golE2;
  @HiveField(7)
  int id;
  @HiveField(8)
  String liga;
  @HiveField(9)
  bool isFinished;

  static int counter = 0;

  Partido({
    this.equipo1,
    this.equipo2,
    this.id,
    this.fecha,
    this.golE1,
    this.golE2,
    this.hora,
    this.numCancha,
    this.liga,
    this.isFinished,
  }) {
    counter += 1;
    this.id = counter; //id tiene que arrancar en 0

    print(
        'Constructor de Partido: Creando el partido entre ${this.equipo1.first.nombre} vs  ${this.equipo2.first.nombre} con id: ${this.id}. El counter vale $counter. key: ${this.key}. El partido es en la fecha: ${this.fecha}');
  }

  // Partido.autoT1T2(Equipo equipo1, Equipo equipo2, Leagues league) {
  //   this.equipo1 = equipo1;
  //   this.equipo2 = equipo2;
  //   this.golE2 = 1;
  //   this.golE1 = 3;
  //   this.id = counter;
  //   this.liga = league.toString();
  //   this.numCancha = 3;
  //   this.hora = '15:30';
  //   // this.fecha = '01-02-03';
  //   print(
  //       'Se creo el partido: ${this.equipo1} vs ${this.equipo2}, con el ID: ${this.id}');
  //   counter += 1;
  // }

  String toString() =>
      'Partido: Creando el partido entre ${this.equipo1.first.nombre} vs  ${this.equipo2.first.nombre} con id: ${this.id}. El counter vale $counter. key: ${this.key}. El partido es en la fecha: ${this.fecha}';

  int get typeId => 2;
}
