// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_product_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedProductImageAdapter extends TypeAdapter<CachedProductImage> {
  @override
  final int typeId = 5;

  @override
  CachedProductImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedProductImage(
      id: fields[0] as int,
      url: fields[1] as String,
      avatar: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CachedProductImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.avatar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedProductImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
