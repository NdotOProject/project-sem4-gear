// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_cart_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedCartItemAdapter extends TypeAdapter<CachedCartItem> {
  @override
  final int typeId = 2;

  @override
  CachedCartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedCartItem(
      id: fields[0] as int?,
      productId: fields[1] as int,
      quantity: fields[2] as int,
      selected: fields[3] as bool,
    )
      ..sizeId = fields[4] as int?
      ..colorId = fields[5] as int?
      ..price = fields[6] as double?;
  }

  @override
  void write(BinaryWriter writer, CachedCartItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.selected)
      ..writeByte(4)
      ..write(obj.sizeId)
      ..writeByte(5)
      ..write(obj.colorId)
      ..writeByte(6)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedCartItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
