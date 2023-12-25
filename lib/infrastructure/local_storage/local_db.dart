import 'package:de_nada/domain/entity/weather_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  Box? _weatherBox;
// open box for storage
  openBox() async {
    await Hive.openBox("weather_box").then((_box) {
      _weatherBox = _box;
    });
  }

// add the fetched weather data
  Future<void> addWeather(WeatherModel weatherModel) async {
    await _weatherBox?.clear();
    await _weatherBox?.add(weatherModel);
  }

//  get the saved weather data
  Future<WeatherModel?> getWeather() async {
    WeatherModel? weatherData = await _weatherBox?.get(0);
    return weatherData;
  }
}
