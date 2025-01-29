// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NutritionModelAdapter extends TypeAdapter<NutritionModel> {
  @override
  final int typeId = 6;

  @override
  NutritionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutritionModel(
      makerModel: fields[0] as MakerModel?,
      handmadeModel: fields[1] as HandmadeModel?,
    )
      ..id = fields[2] as String
      ..createdAt = fields[3] as DateTime;
  }

  @override
  void write(BinaryWriter writer, NutritionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.makerModel)
      ..writeByte(1)
      ..write(obj.handmadeModel)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutritionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
