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
      productId: fields[0] as int,
      quantity: fields[1] as int,
      selected: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CachedCartItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.quantity)
      ..writeByte(2)
      ..write(obj.selected);
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
