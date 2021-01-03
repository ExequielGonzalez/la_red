import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:hive/hive.dart';

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
  });

  @override
  int get typeId => 1;
}
