// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoryRecordAdapter extends TypeAdapter<StoryRecord> {
  @override
  final int typeId = 0;

  @override
  StoryRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoryRecord(
      by: fields[0] as String?,
      descendants: fields[1] as int?,
      id: fields[2] as int?,
      kids: (fields[3] as List?)?.cast<int>(),
      score: fields[4] as int?,
      time: fields[5] as int?,
      title: fields[6] as String?,
      type: fields[7] as String?,
      url: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StoryRecord obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.by)
      ..writeByte(1)
      ..write(obj.descendants)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.kids)
      ..writeByte(4)
      ..write(obj.score)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
