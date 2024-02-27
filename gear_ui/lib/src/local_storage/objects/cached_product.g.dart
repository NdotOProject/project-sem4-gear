// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedProductAdapter extends TypeAdapter<CachedProduct> {
  @override
  final int typeId = 1;

  @override
  CachedProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedProduct(
      id: fields[0] as int,
      code: fields[1] as String,
      brandId: fields[2] as int,
      categoryId: fields[3] as int,
      name: fields[4] as String,
      description: fields[5] as String?,
      avatar: fields[6] as String?,
      images: (fields[7] as List?)?.cast<String>(),
      color: fields[9] as String,
      size: fields[8] as int,
      price: fields[10] as double,
      rating: fields[13] as double,
      cartQuantity: fields[12] as int,
      currentQuantity: fields[11] as int,
      feedbacks: (fields[14] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CachedProduct obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.brandId)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.avatar)
      ..writeByte(7)
      ..write(obj.images)
      ..writeByte(8)
      ..write(obj.size)
      ..writeByte(9)
      ..write(obj.color)
      ..writeByte(10)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.currentQuantity)
      ..writeByte(12)
      ..write(obj.cartQuantity)
      ..writeByte(13)
      ..write(obj.rating)
      ..writeByte(14)
      ..write(obj.feedbacks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
