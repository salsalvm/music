// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsAdapter extends TypeAdapter<Songs> {
  @override
  final int typeId = 0;

  @override
  Songs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Songs(
      id: fields[4] as int?,
      artist: fields[0] as String?,
      duration: fields[2] as int?,
      songname: fields[1] as String?,
      songurl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Songs obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.artist)
      ..writeByte(1)
      ..write(obj.songname)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.songurl)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
