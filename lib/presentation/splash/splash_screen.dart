import 'package:auto_route/auto_route.dart';
import 'package:de_nada/infrastructure/local_storage/local_db.dart';
import 'package:de_nada/injection_container.dart';
import 'package:de_nada/presentation/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../application/bloc/auth_bloc/auth_bloc.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(UserAlreadySignedInEvent());
    serviceLocator.get<LocalDb>().openBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is UserNotSignedIn) {
            Future.delayed(
              const Duration(seconds: 3),
              () {
                AutoRouter.of(context).replace(const SignUpRoute());
              },
            );
          }
          if (state is AuthSuccess) {
            Future.delayed(
              const Duration(seconds: 3),
              () {
                AutoRouter.of(context).replace(const WeatherRoute());
              },
            );
          }
        },
        child: Center(
          child: 
              Lottie.asset("assets/loading_json.json"),
        ),
      ),
    );
  }
}
