// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groceries_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroceriesModelAdapter extends TypeAdapter<GroceriesModel> {
  @override
  final int typeId = AppConstant.groceriesModelHiveId;

  @override
  GroceriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{};
    for (int i = 0; i < numOfFields; i++) {
      fields[reader.readByte()] = reader.read();
    }
    return GroceriesModel(
      name: fields[0] as String,
      kcalPer100g: (fields[1] as double) * 100,
      gram: fields[2] as int,
    )
      ..id = fields[7] as String
      ..createdAt = fields[8] as DateTime;
  }

  @override
  void write(BinaryWriter writer, GroceriesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj._kcalPerGram)
      ..writeByte(2)
      ..write(obj.gram)
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
      other is GroceriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
