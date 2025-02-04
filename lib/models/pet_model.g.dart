// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetModelAdapter extends TypeAdapter<PetModel> {
  @override
  final int typeId = 0;

  @override
  PetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetModel(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
      birthDay: fields[2] as DateTime,
      genderType: fields[3] as GENDER_TYPE,
      weight: fields[6] as double,
      isNeuter: fields[4] as bool?,
      nutritionModel: fields[9] as NutritionModel?,
      isPregnancy: fields[5] as bool?,
    )
      ..id = fields[7] as String
      ..createdAt = fields[8] as DateTime;
  }

  @override
  void write(BinaryWriter writer, PetModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.birthDay)
      ..writeByte(3)
      ..write(obj.genderType)
      ..writeByte(4)
      ..write(obj.isNeuter)
      ..writeByte(5)
      ..write(obj.isPregnancy)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(9)
      ..write(obj.nutritionModel)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
