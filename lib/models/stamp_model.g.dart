// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StampModelAdapter extends TypeAdapter<StampModel> {
  @override
  final int typeId = 3;

  @override
  StampModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StampModel(
      name: fields[0] as String,
      icon: fields[1] as IconData,
    );
  }

  @override
  void write(BinaryWriter writer, StampModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StampModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
