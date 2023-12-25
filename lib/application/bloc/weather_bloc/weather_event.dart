// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weather_bloc.dart';

sealed class WeatherEvent {}

class WeatherFetched extends WeatherEvent {}

class WeatherFetchedCurrentLocation extends WeatherEvent {
  
   
}

class WeatherFetchedSearchedCity extends WeatherEvent {
  String city;
  WeatherFetchedSearchedCity({
    required this.city,
  });
}
