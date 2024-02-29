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
      price: fields[6] as double,
      rating: fields[7] as double,
      imageUrls: (fields[8] as List?)?.cast<String>(),
      avatarImageUrl: fields[9] as String?,
      sizeIds: (fields[10] as List).cast<int>(),
      colorIds: (fields[11] as List).cast<int>(),
      feedbackIds: (fields[12] as List).cast<int>(),
      quantity: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CachedProduct obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.imageUrls)
      ..writeByte(9)
      ..write(obj.avatarImageUrl)
      ..writeByte(10)
      ..write(obj.sizeIds)
      ..writeByte(11)
      ..write(obj.colorIds)
      ..writeByte(12)
      ..write(obj.feedbackIds)
      ..writeByte(13)
      ..write(obj.quantity);
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
