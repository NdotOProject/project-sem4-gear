// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_product_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedProductDetailAdapter extends TypeAdapter<CachedProductDetail> {
  @override
  final int typeId = 2;

  @override
  CachedProductDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedProductDetail(
      id: fields[0] as int,
      productId: fields[1] as int,
      size: fields[2] as CachedProductSize,
      color: fields[3] as CachedProductColor,
      images: (fields[4] as List).cast<CachedProductImage>(),
      quantity: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CachedProductDetail obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.size)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedProductDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
