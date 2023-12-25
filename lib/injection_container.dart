import 'package:de_nada/infrastructure/local_storage/local_db.dart';
import 'package:de_nada/infrastructure/network_client.dart';
import 'package:de_nada/infrastructure/repositories/auth_repo.dart';
import 'package:de_nada/infrastructure/repositories/location_repo.dart';
import 'package:de_nada/infrastructure/repositories/weather_repo.dart';
import 'package:de_nada/presentation/app_router.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


// dependency injection file
final serviceLocator = GetIt.instance;

void serviceLocatorSetUp() {
  serviceLocator.registerSingleton<LocalDb>(LocalDb());
  serviceLocator.registerLazySingleton<AppRouter>(() => AppRouter());
  serviceLocator.registerLazySingleton<AuthRepo>(() => AuthRepo());
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  // serviceLocator.registerSingleton<Dio>(Dio());
  serviceLocator.registerLazySingleton<NetworkClient>(() => NetworkClient());
  // serviceLocator.registerSingleton<NetworkClient>(NetworkClient());
  serviceLocator.registerSingleton<LocationRepo>(LocationRepo());
  serviceLocator.registerSingleton<WeatherRepo>(WeatherRepo());
}
