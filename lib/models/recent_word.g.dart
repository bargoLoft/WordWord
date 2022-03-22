// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentWordAdapter extends TypeAdapter<RecentWord> {
  @override
  final int typeId = 1;

  @override
  RecentWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentWord(
      fields[0] as String,
      fields[1] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentWord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.targetCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
