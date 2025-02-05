// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handmade_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HandmadeModelAdapter extends TypeAdapter<HandmadeModel> {
  @override
  final int typeId = 8;

  @override
  HandmadeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HandmadeModel(
      givenGramPerDay: fields[0] as int,
      givenVegetableGram: fields[1] as int,
      givenProteinGram: fields[2] as int,
    )
      ..id = fields[3] as String
      ..createdAt = fields[4] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HandmadeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.givenGramPerDay)
      ..writeByte(1)
      ..write(obj.givenVegetableGram)
      ..writeByte(2)
      ..write(obj.givenProteinGram)
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
      other is HandmadeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
