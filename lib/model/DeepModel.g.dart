// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeepModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeepModelAdapter extends TypeAdapter<DeepModel> {
  @override
  final int typeId = 0;

  @override
  DeepModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeepModel(
      video_path: fields[0] as String,
      name: fields[1] as String,
      result: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DeepModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.video_path)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.result)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeepModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
