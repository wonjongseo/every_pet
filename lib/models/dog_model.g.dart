// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DogModelAdapter extends TypeAdapter<DogModel> {
  @override
  final int typeId = 1;

  @override
  DogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DogModel(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
      birthDay: fields[2] as DateTime,
      genderType: fields[3] as GENDER_TYPE,
      weight: fields[6] as double,
      isNeuter: fields[4] as bool?,
      isPregnancy: fields[5] as bool?,
    )
      ..nutritionModel = fields[9] as NutritionModel?
      ..id = fields[7] as String
      ..createdAt = fields[8] as DateTime;
  }

  @override
  void write(BinaryWriter writer, DogModel obj) {
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
      other is DogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GENDERTYPEAdapter extends TypeAdapter<GENDER_TYPE> {
  @override
  final int typeId = 2;

  @override
  GENDER_TYPE read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GENDER_TYPE.MALE;
      case 1:
        return GENDER_TYPE.FEMALE;
      default:
        return GENDER_TYPE.MALE;
    }
  }

  @override
  void write(BinaryWriter writer, GENDER_TYPE obj) {
    switch (obj) {
      case GENDER_TYPE.MALE:
        writer.writeByte(0);
        break;
      case GENDER_TYPE.FEMALE:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GENDERTYPEAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
