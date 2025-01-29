// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maker_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MakerModelAdapter extends TypeAdapter<MakerModel> {
  @override
  final int typeId = 7;

  @override
  MakerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MakerModel(
      makerName: fields[0] as String,
      givenCountPerDay: fields[1] as int,
      givenGramOnce: fields[2] as double,
    )
      ..id = fields[3] as String
      ..createdAt = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, MakerModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.makerName)
      ..writeByte(1)
      ..write(obj.givenCountPerDay)
      ..writeByte(2)
      ..write(obj.givenGramOnce)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
