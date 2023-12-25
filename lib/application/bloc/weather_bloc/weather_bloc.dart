import 'package:bloc/bloc.dart';
import 'package:de_nada/domain/entity/weather_model.dart';
import 'package:de_nada/infrastructure/local_storage/local_db.dart';
import 'package:de_nada/infrastructure/repositories/location_repo.dart';
import 'package:de_nada/infrastructure/repositories/weather_repo.dart';
import 'package:de_nada/injection_container.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final weatherRepo = serviceLocator.get<WeatherRepo>();
  final locationService = serviceLocator.get<LocationRepo>();
  final localDb = serviceLocator.get<LocalDb>();
  WeatherBloc() : super(WeatherInitial()) {
    // on<WeatherFetched>((event, emit) {
    //   emit(WeatherSuccess());
    // });
    on<WeatherFetched>(_getCurrentWeather);
    on<WeatherFetchedSearchedCity>(_getCityWeather);
    on<WeatherFetchedCurrentLocation>(_getLocationWeather);
  }

// get thr current weather
  Future<void> _getCurrentWeather(
      WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepo.getCurrentWeather();

      emit(WeatherSuccess(weather));
      await localDb.addWeather(weather);
    } catch (e) {
      print("getCurrWea");
      WeatherModel? localWeather = await localDb.getWeather();

      if (localWeather != null) {
        emit(WeatherFailure(e.toString()));
        emit(WeatherSuccess(localWeather));
      } else {
        emit(WeatherFailure(e.toString()));
      }
    }
  }

  // get specific city weather
  Future<void> _getCityWeather(
      WeatherFetchedSearchedCity event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepo.getCurrentWeather(cityName: event.city);
      emit(WeatherSuccess(weather));
      await localDb.addWeather(weather);
    } catch (e) { 
      WeatherModel? localWeather = await localDb.getWeather();

      if (localWeather != null) {
        emit(WeatherFailure(e.toString()));
        emit(WeatherSuccess(localWeather));
      } else {
        emit(WeatherFailure(e.toString()));
      }
    }
  }

  Future<void> _getLocationWeather(
      WeatherFetchedCurrentLocation event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepo.getCurrentLocationWeather(
          position: await locationService.checkPermission());
      emit(WeatherSuccess(weather));
      await localDb.addWeather(weather);
    } catch (e) {
      print("getLocWea");
      WeatherModel? localWeather = await localDb.getWeather();
      print(localWeather?.city);
      if (localWeather != null) {
        emit(WeatherFailure(e.toString()));
        emit(WeatherSuccess(localWeather));
      } else {
        emit(WeatherFailure(e.toString()));
      }
    }
  }
}
