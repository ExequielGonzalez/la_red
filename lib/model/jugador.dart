import 'package:hive/hive.dart';

part 'jugador.g.dart';

@HiveType(typeId: 0)
class Jugador {
  @HiveField(0)
  String nombre;
  @HiveField(1)
  String apellido;
  @HiveField(2)
  int edad;
  @HiveField(3)
  int goles;
  @HiveField(4)
  int amarillas;
  @HiveField(5)
  int rojas;
  @HiveField(6)
  int dni;

  Jugador({
    this.nombre,
    this.apellido,
    this.dni,
    this.edad,
    this.amarillas,
    this.goles,
    this.rojas,
  });

  @override
  int get typeId => 0;
}
