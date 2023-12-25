import 'package:de_nada/application/bloc/auth_bloc/auth_bloc.dart';
import 'package:de_nada/application/bloc/weather_bloc/weather_bloc.dart';
import 'package:de_nada/injection_container.dart';
import 'package:de_nada/presentation/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'domain/entity/weather_model.dart';
import 'firebase_options.dart';
import 'presentation/constants.dart';

// for generating routes and hive adaptor ->   dart run build_runner build --delete-conflicting-outputs

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  serviceLocatorSetUp();
  final docDir = await getApplicationDocumentsDirectory();
  Hive.init(docDir.path);
  Hive.registerAdapter(WeatherModelAdaptor());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc(),
          ),
          BlocProvider(
            create: (context) => AuthBloc(),
          )
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: serviceLocator.get<AppRouter>().config(),
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Pallete.backgroundColor,
          ),
        ));
  }
}
