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
      puntos: fields[1] as int,
      golesContra: fields[4] as int,
      golesFavor: fields[3] as int,
      partidosEmpates: fields[7] as int,
      partidosGanados: fields[5] as int,
      partidosJugados: fields[2] as int,
      partidosPerdidos: fields[6] as int,
      id: fields[9] as String,
      jugadores: (fields[0] as HiveList)?.castHiveList(),
      nombre: fields[8] as String,
      photoURL: fields[10] as Uint8List,
      liga: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Equipo obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.jugadores)
      ..writeByte(1)
      ..write(obj.puntos)
      ..writeByte(2)
      ..write(obj.partidosJugados)
      ..writeByte(3)
      ..write(obj.golesFavor)
      ..writeByte(4)
      ..write(obj.golesContra)
      ..writeByte(5)
      ..write(obj.partidosGanados)
      ..writeByte(6)
      ..write(obj.partidosPerdidos)
      ..writeByte(7)
      ..write(obj.partidosEmpates)
      ..writeByte(8)
      ..write(obj.nombre)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.photoURL)
      ..writeByte(11)
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
