// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_product_size.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedProductSizeAdapter extends TypeAdapter<CachedProductSize> {
  @override
  final int typeId = 6;

  @override
  CachedProductSize read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedProductSize(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String?,
      productIds: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CachedProductSize obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.productIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedProductSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
