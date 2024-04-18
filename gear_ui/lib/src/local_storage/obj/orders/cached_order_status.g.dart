// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_order_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedOrderStatusAdapter extends TypeAdapter<CachedOrderStatus> {
  @override
  final int typeId = 100;

  @override
  CachedOrderStatus read(BinaryReader reader) {
    return CachedOrderStatus();
  }

  @override
  void write(BinaryWriter writer, CachedOrderStatus obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedOrderStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
