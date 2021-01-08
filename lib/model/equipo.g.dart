// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquipoAdapter extends TypeAdapter<Equipo> {
  @override
  final int typeId = 1;

  @override
  Equipo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Equipo(
      puntos: fields[2] as int,
      golesContra: fields[5] as int,
      golesFavor: fields[4] as int,
      partidosEmpates: fields[8] as int,
      partidosGanados: fields[6] as int,
      partidosJugados: fields[3] as int,
      partidosPerdidos: fields[7] as int,
      id: fields[10] as int,
      jugadores: (fields[0] as List)?.cast<Jugador>(),
      nombre: fields[9] as String,
      partidosAnteriores: (fields[1] as List)?.cast<Partido>(),
      photoURL: fields[11] as String,
      liga: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Equipo obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.jugadores)
      ..writeByte(1)
      ..write(obj.partidosAnteriores)
      ..writeByte(2)
      ..write(obj.puntos)
      ..writeByte(3)
      ..write(obj.partidosJugados)
      ..writeByte(4)
      ..write(obj.golesFavor)
      ..writeByte(5)
      ..write(obj.golesContra)
      ..writeByte(6)
      ..write(obj.partidosGanados)
      ..writeByte(7)
      ..write(obj.partidosPerdidos)
      ..writeByte(8)
      ..write(obj.partidosEmpates)
      ..writeByte(9)
      ..write(obj.nombre)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.photoURL)
      ..writeByte(12)
      ..write(obj.liga);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
