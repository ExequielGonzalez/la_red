import 'package:hive/hive.dart';

import '../constants.dart';
import 'dart:developer' as dev;
part 'jugador.g.dart';

@HiveType(typeId: 0)
class Jugador extends HiveObject {
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
  @HiveField(10)
  String keyDataBase;

  //TODO: Añadir que cada jugador pertenezca a un equipo
  static int counter = 1;

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
    this.keyDataBase,
  }) {
    this.id = counter; //id tiene que arrancar en 1
    // dev.debugger();
    counter += 1;
    print(
        'Constructor de Jugador: Creando jugador ${this.nombre} ${this.apellido} con id: ${this.id}. El counter vale $counter. key: ${this.key}');
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

  int compareTo(other) {
    // TODO: implement compareTo
    return -this.goles.compareTo(other.goles);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: ${this.id}  - counter: $counter - key: ${this.key}-> El jugador ${this.nombre} ${this.apellido}, con DNI: ${this.dni}, que juega en la liga ${this.liga} y ha hecho ${this.goles} goles';
    return super.toString();
  }

  @override
  int get typeId => 0;
}
