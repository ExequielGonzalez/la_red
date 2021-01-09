import 'package:la_red/model/equipo.dart';
import 'package:hive/hive.dart';

import '../constants.dart';

part 'partido.g.dart';

@HiveType(typeId: 2)
class Partido {
  @HiveField(0)
  Equipo equipo1;
  @HiveField(1)
  Equipo equipo2;
  @HiveField(2)
  int numCancha;
  @HiveField(3)
  String fecha;
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
  });

  Partido.autoT1T2(Equipo equipo1, Equipo equipo2, Leagues league) {
    this.equipo1 = equipo1;
    this.equipo2 = equipo2;
    this.golE2 = 1;
    this.golE1 = 3;
    this.id = counter;
    this.liga = league.toString();
    this.numCancha = 3;
    this.hora = '15:30';
    this.fecha = '01-02-03';
    print(
        'Se creo el partido: ${this.equipo1} vs ${this.equipo2}, con el ID: ${this.id}');
    counter += 1;
  }

  int get typeId => 2;
}
