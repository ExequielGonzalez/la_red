import 'package:hive/hive.dart';

import '../constants.dart';

part 'jugador.g.dart';

@HiveType(typeId: 0)
class Jugador extends Comparable {
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
  @HiveField(7)
  int posicion;
  @HiveField(8)
  String liga;
  @HiveField(9)
  int id;

  //TODO: Añadir que cada jugador pertenezca a un equipo
  static int counter = 0;

  Jugador({
    this.nombre,
    this.apellido,
    this.dni,
    this.edad,
    this.amarillas,
    this.goles,
    this.rojas,
    this.posicion,
    this.liga,
    this.id,
  }) {
    counter += 1;
    this.id = counter; //id tiene que arrancar en 1
  }

  Jugador.auto(String name, Leagues league) {
    this.nombre = name;
    this.apellido = '';
    this.dni = counter;
    this.edad = 23;
    this.amarillas = 1;
    this.goles = counter * 5;
    this.rojas = 0;
    this.posicion = counter + 1;
    this.liga = league.toString();

    print('Se creo el jugador: ${this.nombre}, con el DNI: ${this.dni}');
    counter += 1;
  }

  @override
  int compareTo(other) {
    // TODO: implement compareTo
    return -this.goles.compareTo(other.goles);
  }

  @override
  String toString() {
    // TODO: implement toString
    print(
        'El jugador ${this.nombre} ${this.apellido}, con DNI: ${this.dni}, que juega en la liga ${this.liga}');
    return super.toString();
  }

  @override
  int get typeId => 0;
}
