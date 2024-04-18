// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_feedback.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedFeedbackAdapter extends TypeAdapter<CachedFeedback> {
  @override
  final int typeId = 8;

  @override
  CachedFeedback read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedFeedback(
      id: fields[0] as int,
      productId: fields[1] as int,
      userId: fields[2] as int,
      content: fields[3] as String?,
      rating: fields[4] as int,
      updated: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CachedFeedback obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.updated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedFeedbackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
