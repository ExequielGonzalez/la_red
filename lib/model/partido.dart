import 'package:la_red/model/equipo.dart';
import 'package:hive/hive.dart';

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

  Partido({
    this.equipo1,
    this.equipo2,
    this.id,
    this.fecha,
    this.golE1,
    this.golE2,
    this.hora,
    this.numCancha,
  });

  @override
  int get typeId => 2;
}
