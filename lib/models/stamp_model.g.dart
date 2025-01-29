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
      iconIndex: fields[1] as int,
      isVisible: fields[3] as bool,
      isCustom: fields[2] == null ? false : fields[2] as bool,
    )
      ..id = fields[4] as String
      ..createdAt = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, StampModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.iconIndex)
      ..writeByte(2)
      ..write(obj.isCustom)
      ..writeByte(3)
      ..write(obj.isVisible)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.createdAt);
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
