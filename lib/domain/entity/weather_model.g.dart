// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdaptor extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 0;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      currentTemp: fields[0] as String,
      currentSky: fields[1] as String,
      currentPressure: fields[2] as String,
      currentWindSpeed: fields[3] as String,
      currentHumidity: fields[4] as String,
      city: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.currentTemp)
      ..writeByte(1)
      ..write(obj.currentSky)
      ..writeByte(2)
      ..write(obj.currentPressure)
      ..writeByte(3)
      ..write(obj.currentWindSpeed)
      ..writeByte(4)
      ..write(obj.currentHumidity)
      ..writeByte(5)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdaptor &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
