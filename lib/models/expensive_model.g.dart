// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expensive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensiveModelAdapter extends TypeAdapter<ExpensiveModel> {
  @override
  final int typeId = 10;

  @override
  ExpensiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpensiveModel(
      date: fields[3] as DateTime,
      category: fields[0] as String,
      productName: fields[1] as String,
      price: fields[2] as int,
    )
      ..id = fields[4] as String
      ..createdAt = fields[5] as DateTime;
  }

  @override
  void write(BinaryWriter writer, ExpensiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.date)
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
      other is ExpensiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
