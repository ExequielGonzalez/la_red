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
      equipo1: (fields[0] as HiveList)?.castHiveList(),
      equipo2: (fields[1] as HiveList)?.castHiveList(),
      id: fields[6] as String,
      fecha: fields[3] as DateTime,
      golE1: fields[4] as int,
      golE2: fields[5] as int,
      numCancha: fields[2] as int,
      liga: fields[7] as String,
      isFinished: fields[8] as bool,
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
      ..write(obj.golE1)
      ..writeByte(5)
      ..write(obj.golE2)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.liga)
      ..writeByte(8)
      ..write(obj.isFinished);
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
