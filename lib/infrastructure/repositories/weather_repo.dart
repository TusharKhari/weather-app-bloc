import 'package:de_nada/domain/entity/weather_model.dart';
import 'package:de_nada/infrastructure/network_client.dart';
import 'package:de_nada/injection_container.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

import '../constant.dart';

//   weather api calls
class WeatherRepo {
  final service = serviceLocator.get<NetworkClient>();

  // get the current weather
  Future<WeatherModel> getCurrentWeather({String? cityName}) async {
    try {
      String url =
          //  'https://api.openweathermap.org/data/2.5/forecast?lat=28.9833&lon=77.7&APPID=$openWeatherAPIKey';
          'https://api.openweathermap.org/data/2.5/forecast?q=${cityName ?? "Delhi"}&APPID=$openWeatherAPIKey';
      Response? weatherData = await service.createGetRequest(url: url);
      WeatherModel data = WeatherModel.fromJson(weatherData.toString());
      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Connection timeout occurred";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw 'Receive timeout occurred';
      } else if (e.type == DioExceptionType.badResponse) {
        throw "check parameters";
      } else {
        throw e;
      }
    } catch (e) {
      throw e;
    }
  }

// get the weather based on position lat lng
  Future<WeatherModel> getCurrentLocationWeather({Position? position}) async {
    try {
      String url =
          'https://api.openweathermap.org/data/2.5/forecast?lat=${position?.latitude ?? 0}&lon=${position?.longitude ?? 0}&APPID=$openWeatherAPIKey';
      //  'https://api.openweathermap.org/data/2.5/forecast?lat=28.9833&lon=77.7&APPID=$openWeatherAPIKey';
      Response? weatherData = await service.createGetRequest(url: url);
      WeatherModel data = WeatherModel.fromJson(weatherData.toString());
      return data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw "Connection timeout occurred";
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw 'Receive timeout occurred';
      } else if (e.type == DioExceptionType.badResponse) {
        throw "check parameters";
      } else if (e.type == DioExceptionType.connectionError) {
        throw "check internet connection";
      } else {
        throw e;
      }
    } catch (e) {
      throw e;
    }
  }
}
