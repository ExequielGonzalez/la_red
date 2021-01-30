import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:la_red/model/equipo.dart';
import 'package:hive/hive.dart';

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
  int golE1;
  @HiveField(5)
  int golE2;
  @HiveField(6)
  String id;
  @HiveField(7)
  String liga;
  @HiveField(8)
  bool isFinished;

  Partido({
    this.equipo1,
    this.equipo2,
    this.id,
    this.fecha,
    this.golE1,
    this.golE2,
    this.numCancha,
    this.liga,
    this.isFinished,
  }) {
    this.id =
        '${this.fecha.day.toString().padLeft(2, '0')}-${this.fecha.month.toString().padLeft(2, '0')}-${this.fecha.year.toString()}-${this.fecha.millisecond.toString()}-${this.liga}-${this.numCancha.toString()}'; //id tiene que arrancar en 0

    // print(
    //     'Constructor de Partido: Creando el partido entre ${this.equipo1.first.nombre} vs  ${this.equipo2.first.nombre} con id: ${this.id}.  key: ${this.key}. El partido es en la fecha: ${this.fecha}');
  }

  String toString() =>
      'id:${this.id} --- Partido: Creando el partido entre ${this.equipo1.first.nombre} vs  ${this.equipo2.first.nombre} con id: ${this.id}.  key: ${this.key}. El partido es en la fecha: ${this.fecha}';

  Map<dynamic, dynamic> toJson() => _$PartidoToJson(this);

  Map<String, dynamic> _$PartidoToJson(Partido partido) => <String, dynamic>{
        'id': partido.id,
        'fecha': partido.fecha,
        'numCancha': partido.numCancha,
        'golE1': partido.golE1,
        'golE2': partido.golE2,
        'liga': partido.liga,
        'isFinished': partido.isFinished,
        'equipo1': partido.equipo1.map((i) => i.toJson()).toList(),
        'equipo2': partido.equipo2.map((i) => i.toJson()).toList(),
      };

  factory Partido.fromJson(Map<String, dynamic> json) {
    return Partido(
      fecha: json['fecha'].toDate(),
      numCancha: json['numCancha'],
      golE1: json['golE1'],
      golE2: json['golE2'],
      isFinished: json['isFinished'],
      equipo1: json['equipo1'],
      equipo2: json['equipo2'],
      id: json['id'],
      liga: json['liga'],
    );
  }

  factory Partido.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Partido(
      fecha: data['fecha'].toDate(),
      numCancha: data['numCancha'],
      golE1: data['golE1'],
      golE2: data['golE2'],
      isFinished: data['isFinished'],
      // equipo1: data['equipo1'],
      // equipo2: data['equipo2'],
      id: data['id'],
      liga: data['liga'],
    );
  }

  int get typeId => 2;
}
