import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool hasTeam;
  @HiveField(8)
  String liga;
  @HiveField(9)
  int id;
  @HiveField(10)
  String keyDataBase;

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
    this.hasTeam,
    this.liga,
    this.id,
    this.keyDataBase,
  }) {
    // this.hasTeam = false;
    this.id = counter; //id tiene que arrancar en 1
    // dev.debugger();
    counter += 1;
    print(
        'Constructor de Jugador: Creando jugador ${this.nombre} ${this.apellido} con dni: ${this.dni} con id: ${this.id}. El counter vale $counter. key: ${this.key}. El jugador tiene equipo: ${this.hasTeam} y juega en la liga ${this.liga}. la key en la database es ${this.keyDataBase}');
  }

  // factory Jugador.fromJason(Map<String, dynamic> json) =>
  //     _$JugadorFromJson(json);

  Map<dynamic, dynamic> toJson() => _$JugadorToJson(this);

  Jugador.auto(String name, Leagues league) {
    this.nombre = name;
    this.apellido = '';
    this.dni = counter;
    this.edad = 23;
    this.amarillas = 1;
    this.goles = counter * 5;
    this.rojas = 0;
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

  Map<String, dynamic> _$JugadorToJson(Jugador jugador) => <String, dynamic>{
        'nombre': jugador.nombre,
        'apellido': jugador.apellido,
        'dni': jugador.dni,
        'goles': jugador.goles,
        'amarillas': jugador.amarillas,
        'rojas': jugador.rojas,
        'id': jugador.id,
        'liga': jugador.liga,
        'edad': jugador.edad,
        'hasTeam': jugador.hasTeam,
        'keyDataBase': jugador.keyDataBase,
      };

  factory Jugador.fromJson(Map<String, dynamic> json) {
    return Jugador(
      nombre: json['nombre'] as String,
      apellido: json['apellido'] as String,
      dni: json['dni'] as int,
      goles: json['goles'] as int,
      amarillas: json['amarillas'] as int,
      rojas: json['rojas'] as int,
      // id: json['id'] as int,
      liga: json['liga'] as String,
      edad: json['edad'] as int,
      hasTeam: json['hasTeam'] as bool,
      // keyDataBase: json['keyDataBase'] as String,
    );
  }

  factory Jugador.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Jugador(
      nombre: data['nombre'],
      apellido: data['apellido'],
      dni: data['dni'],
      goles: data['goles'],
      amarillas: data['amarillas'],
      rojas: data['rojas'],
      id: data['id'],
      liga: data['liga'],
      edad: data['edad'],
      hasTeam: data['hasTeam'],
      // keyDataBase: data['keyDataBase'],
    )..keyDataBase = doc.id;
  }

  // Jugador _$JugadorFromJson(Map<String, dynamic> json) => Jugador(
  //       nombre: json['nombre'] as String,
  //       apellido: json['apellido'] as String,
  //       dni: json['dni'] as int,
  //       goles: json['goles'] as int,
  //       amarillas: json['amarillas'] as int,
  //       rojas: json['rojas'] as int,
  //       id: json['id'] as int,
  //       liga: json['liga'] as String,
  //       edad: json['edad'] as int,
  //       hasTeam: json['hasTeam'] as bool,
  //       keyDataBase: json['keyDataBase'] as String,
  //     );

  @override
  int get typeId => 0;
}
