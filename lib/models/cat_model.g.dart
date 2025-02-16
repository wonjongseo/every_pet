// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatModelAdapter extends TypeAdapter<CatModel> {
  @override
  final int typeId = 5;

  @override
  CatModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatModel(
      name: fields[0] as String,
      imageUrl: fields[1] as String,
      birthDay: fields[2] as DateTime,
      genderType: fields[3] as GENDER_TYPE,
      weight: fields[6] as double,
      isNeuter: fields[4] as bool?,
      nutritionModel: fields[9] as NutritionModel?,
      isPregnancy: fields[5] as bool?,
      hospitalName: fields[10] as String?,
      hospitalNumber: fields[11] as String?,
      groomingName: fields[12] as String?,
      groomingNumber: fields[13] as String?,
    )
      ..id = fields[7] as String
      ..createdAt = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, CatModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageName)
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
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.nutritionModel)
      ..writeByte(10)
      ..write(obj.hospitalName)
      ..writeByte(11)
      ..write(obj.hospitalNumber)
      ..writeByte(12)
      ..write(obj.groomingName)
      ..writeByte(13)
      ..write(obj.groomingNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
