// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'weather_model.g.dart';


// model for storing instance of fetched weather data

@HiveType(typeId: 0, adapterName: "WeatherModelAdaptor")
class WeatherModel {
  @HiveField(0)
  final String currentTemp;
  @HiveField(1)
  final String currentSky;
  @HiveField(2)
  final String currentPressure;
  @HiveField(3)
  final String currentWindSpeed;
  @HiveField(4)
  final String currentHumidity;
  @HiveField(5)
  final String city;
  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.city,
  });

  WeatherModel copyWith({
    String? currentTemp,
    String? currentSky,
    String? currentPressure,
    String? currentWindSpeed,
    String? currentHumidity,
    String? city,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'city': city,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final city = map['city']["name"];
    return WeatherModel(
      currentTemp:
          (double.parse(currentWeatherData['main']['temp'].toString()) - 273.15)
              .toString()
              .substring(0, 5),
      // currentTemp: currentWeatherData['main']['temp'],
      currentSky: currentWeatherData['weather'][0]['main'].toString(),
      currentPressure: currentWeatherData['main']['pressure'].toString(),
      currentWindSpeed: currentWeatherData['wind']['speed'].toString(),
      currentHumidity: currentWeatherData['main']['humidity'].toString(),
      city: city.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, city: $city)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        other.city == city;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        city.hashCode;
  }
}
