// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

sealed class WeatherState {}

class WeatherInitial extends WeatherState {}


class WeatherFailure extends WeatherState {
  
  String error;
  WeatherFailure(
     this.error,
  );

}
class WeatherLoading extends WeatherState {}
class WeatherSuccess extends WeatherState {
  WeatherModel weather;
  WeatherSuccess(
     this.weather,
  );
}
