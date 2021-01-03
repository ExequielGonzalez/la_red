// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jugador.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JugadorAdapter extends TypeAdapter<Jugador> {
  @override
  final int typeId = 0;

  @override
  Jugador read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Jugador(
      nombre: fields[0] as String,
      apellido: fields[1] as String,
      dni: fields[6] as int,
      edad: fields[2] as int,
      amarillas: fields[4] as int,
      goles: fields[3] as int,
      rojas: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Jugador obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.apellido)
      ..writeByte(2)
      ..write(obj.edad)
      ..writeByte(3)
      ..write(obj.goles)
      ..writeByte(4)
      ..write(obj.amarillas)
      ..writeByte(5)
      ..write(obj.rojas)
      ..writeByte(6)
      ..write(obj.dni);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JugadorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
