// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class wordtestAdapter extends TypeAdapter<wordtest> {
  @override
  final int typeId = 0;

  @override
  wordtest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return wordtest(
      fields[0] as String,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] ?? '' as String,
    );
  }

  @override
  void write(BinaryWriter writer, wordtest obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.supNo)
      ..writeByte(2)
      ..write(obj.pos)
      ..writeByte(3)
      ..write(obj.definition)
      ..writeByte(4)
      ..write(obj.targetCode)
      ..writeByte(5)
      ..write(obj.saveTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is wordtestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
