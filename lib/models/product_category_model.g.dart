// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductCategoryModelAdapter extends TypeAdapter<ProductCategoryModel> {
  @override
  final int typeId = 11;

  @override
  ProductCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCategoryModel(
      name: fields[0] as String,
    )
      ..id = fields[1] as String
      ..createdAt = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, ProductCategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
