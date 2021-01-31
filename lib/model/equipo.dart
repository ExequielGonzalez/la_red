import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_red/model/jugador.dart';
import 'package:la_red/model/partido.dart';
import 'package:hive/hive.dart';

import '../constants.dart';

part 'equipo.g.dart';

@HiveType(typeId: 1)
class Equipo extends HiveObject {
  @HiveField(0)
  HiveList<Jugador> jugadores;
  // @HiveField(1)
  // HiveList<Partido> partidosAnteriores;
  @HiveField(1)
  int puntos;
  @HiveField(2)
  int partidosJugados;
  @HiveField(3)
  int golesFavor;
  @HiveField(4)
  int golesContra;
  @HiveField(5)
  int partidosGanados;
  @HiveField(6)
  int partidosPerdidos;
  @HiveField(7)
  int partidosEmpates;
  @HiveField(8)
  String nombre;
  @HiveField(9)
  String id;
  @HiveField(10)
  Uint8List photoURL;
  @HiveField(11)
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
    // this.partidosAnteriores,
    this.photoURL,
    this.liga,
  }) {
    this.id = this.nombre + this.liga;

    print(
        'Constructor de Equipo: Creando equipo ${this.nombre} con id: ${this.id}. El counter vale $counter. key: ${this.key}. Los jugadores del equipo son: ${jugadores.toString()}');
  }

  Equipo.auto() {
    this.puntos = 16;
    this.golesContra = 10;
    this.golesFavor = 20;
    this.partidosEmpates = 11;
    this.partidosGanados = 12;
    this.partidosJugados = 35;
    this.partidosPerdidos = 12;

    this.jugadores = null;
    this.nombre = 'Boca Juniors';
    // this.partidosAnteriores = null;
    // this.photoURL = "assets/images/contacto.png";
    this.liga = Leagues.femenino.toString();

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

    this.jugadores = null;
    this.nombre = name;
    // this.partidosAnteriores = null;
    // this.photoURL = "assets/images/contacto.png";
    this.liga = league.toString();

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
    var sortByPuntos = a.puntos.compareTo(b.puntos);
    if (sortByPuntos != 0)
      return sortByPuntos;
    else
      return a.golesFavor.compareTo(b.golesFavor);
  }

  Map<dynamic, dynamic> toJson() => _$EquipoToJson(this);

  Map<String, dynamic> _$EquipoToJson(Equipo equipo) => <String, dynamic>{
        'nombre': equipo.nombre,
        'puntos': equipo.puntos,
        'partidosJugados': equipo.partidosJugados,
        'golesFavor': equipo.golesFavor,
        'golesContra': equipo.golesContra,
        'partidosGanados': equipo.partidosGanados,
        'partidosPerdidos': equipo.partidosPerdidos,
        'partidosEmpates': equipo.partidosEmpates,
        // 'photoURL': equipo.photoURL,
        'jugadores': equipo.jugadores.map((i) => i.toJson()).toList(),
        // 'partidosAnteriores':
        //     equipo.partidosAnteriores.map((i) => i.toJson()).toList(),
        'id': equipo.id,
        'liga': equipo.liga,
      };

  factory Equipo.fromJson(Map<String, dynamic> json) {
    return Equipo(
      nombre: json['nombre'] as String,
      puntos: json['puntos'] as int,
      partidosJugados: json['partidosJugados'] as int,
      golesFavor: json['golesFavor'] as int,
      golesContra: json['golesContra'] as int,
      partidosGanados: json['partidosGanados'] as int,
      partidosPerdidos: json['partidosPerdidos'] as int,
      partidosEmpates: json['partidosEmpates'] as int,
      // photoURL: json['photoURL'] as Uint8List,
      // jugadores: json['jugadores'] as List<Jugador>,
      // partidosAnteriores: json['partidosAnteriores'] as List<Partido>,
      id: json['id'] as String,
      liga: json['liga'] as String,
    );
  }

  // factory Equipo.fromFirestore(DocumentSnapshot doc, foto) {
  //   // var players = await Hive.openBox<Jugador>(kBoxJugadores);
  //   Map data = doc.data();
  //   return Equipo(
  //     nombre: data['nombre'],
  //     puntos: data['puntos'],
  //     partidosJugados: data['partidosJugados'],
  //     golesFavor: data['golesFavor'],
  //     golesContra: data['golesContra'],
  //     partidosGanados: data['partidosGanados'],
  //     partidosPerdidos: data['partidosPerdidos'],
  //     partidosEmpates: data['partidosEmpates'],
  //     // photoURL: data['photoURL'],
  //     photoURL: foto,
  //     // jugadores:  HiveList(box, objects: jugadores),
  //     // partidosAnteriores: data['partidosAnteriores'],
  //     id: data['id'],
  //     liga: data['liga'],
  //   );
  // }

  factory Equipo.fromFirestore(DocumentSnapshot doc) {
    // var players = await Hive.openBox<Jugador>(kBoxJugadores);
    Map data = doc.data();
    return Equipo(
      nombre: data['nombre'],
      puntos: data['puntos'],
      partidosJugados: data['partidosJugados'],
      golesFavor: data['golesFavor'],
      golesContra: data['golesContra'],
      partidosGanados: data['partidosGanados'],
      partidosPerdidos: data['partidosPerdidos'],
      partidosEmpates: data['partidosEmpates'],
      // photoURL: data['photoURL'],
      // photoURL: foto,
      // jugadores:  HiveList(box, objects: jugadores),
      // partidosAnteriores: data['partidosAnteriores'],
      id: data['id'],
      liga: data['liga'],
    );
  }
}
