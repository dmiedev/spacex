// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_filters.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaunchFiltersAdapter extends TypeAdapter<LaunchFilters> {
  @override
  final int typeId = 2;

  @override
  LaunchFilters read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LaunchFilters(
      time: fields[0] as LaunchTime?,
      fromDate: fields[1] as DateTime?,
      toDate: fields[2] as DateTime?,
      flightNumber: fields[3] as int?,
      successfulness: fields[4] as LaunchSuccessfulness?,
      rocketIds: (fields[5] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, LaunchFilters obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.fromDate)
      ..writeByte(2)
      ..write(obj.toDate)
      ..writeByte(3)
      ..write(obj.flightNumber)
      ..writeByte(4)
      ..write(obj.successfulness)
      ..writeByte(5)
      ..write(obj.rocketIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaunchFiltersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LaunchTimeAdapter extends TypeAdapter<LaunchTime> {
  @override
  final int typeId = 0;

  @override
  LaunchTime read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LaunchTime.past;
      case 1:
        return LaunchTime.upcoming;
      default:
        return LaunchTime.past;
    }
  }

  @override
  void write(BinaryWriter writer, LaunchTime obj) {
    switch (obj) {
      case LaunchTime.past:
        writer.writeByte(0);
        break;
      case LaunchTime.upcoming:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaunchTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LaunchSuccessfulnessAdapter extends TypeAdapter<LaunchSuccessfulness> {
  @override
  final int typeId = 1;

  @override
  LaunchSuccessfulness read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LaunchSuccessfulness.any;
      case 1:
        return LaunchSuccessfulness.success;
      case 2:
        return LaunchSuccessfulness.failure;
      default:
        return LaunchSuccessfulness.any;
    }
  }

  @override
  void write(BinaryWriter writer, LaunchSuccessfulness obj) {
    switch (obj) {
      case LaunchSuccessfulness.any:
        writer.writeByte(0);
        break;
      case LaunchSuccessfulness.success:
        writer.writeByte(1);
        break;
      case LaunchSuccessfulness.failure:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LaunchSuccessfulnessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
