// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partido.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartidoAdapter extends TypeAdapter<Partido> {
  @override
  final int typeId = 2;

  @override
  Partido read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Partido(
      equipo1: fields[0] as Equipo,
      equipo2: fields[1] as Equipo,
      id: fields[7] as int,
      fecha: fields[3] as String,
      golE1: fields[5] as int,
      golE2: fields[6] as int,
      hora: fields[4] as String,
      numCancha: fields[2] as int,
      liga: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Partido obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.equipo1)
      ..writeByte(1)
      ..write(obj.equipo2)
      ..writeByte(2)
      ..write(obj.numCancha)
      ..writeByte(3)
      ..write(obj.fecha)
      ..writeByte(4)
      ..write(obj.hora)
      ..writeByte(5)
      ..write(obj.golE1)
      ..writeByte(6)
      ..write(obj.golE2)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.liga);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartidoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
