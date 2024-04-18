// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_product_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedProductCategoryAdapter extends TypeAdapter<CachedProductCategory> {
  @override
  final int typeId = 3;

  @override
  CachedProductCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedProductCategory(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CachedProductCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedProductCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
