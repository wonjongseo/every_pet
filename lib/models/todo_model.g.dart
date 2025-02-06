// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 4;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      stamps: (fields[1] as List).cast<StampModel>(),
      memo: fields[2] as String,
      dateTime: fields[3] as DateTime,
      petModel: fields[6] as PetModel?,
    )
      ..startTime = fields[4] as DateTime?
      ..endTime = fields[5] as DateTime?
      ..color = fields[7] as int?
      ..id = fields[8] as String
      ..createdAt = fields[9] as int;
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.stamps)
      ..writeByte(2)
      ..write(obj.memo)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.petModel)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.id)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
