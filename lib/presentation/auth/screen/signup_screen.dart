import 'package:auto_route/auto_route.dart';
import 'package:de_nada/application/bloc/auth_bloc/auth_bloc.dart';
import 'package:de_nada/presentation/app_router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/gradient_button.dart';
import '../widget/login_field.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        // TODO: implement listener
        if (state is AuthSuccess) {
          AutoRouter.of(context).replace(const WeatherRoute());
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
          AutoRouter.of(context).push(ErrorRoute());
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset('assets/signin_balls.png'),
                const Text(
                  'Sign Up.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 50),
                LoginField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                LoginField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 20),
                state is AuthLoading
                    ? CupertinoActivityIndicator()
                    : GradientButton(
                        text: "Sign up",
                        onPressed: () {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            context.read<AuthBloc>().add(SignUpEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ));
                          }
                        },
                      ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    AutoRouter.of(context).replace(
                      const LoginRoute(),
                    );
                  },
                  child: const Text.rich(
                      TextSpan(text: "Already have Account ? ", children: [
                    TextSpan(
                        text: "Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            decoration: TextDecoration.underline))
                  ])),
                )
              ],
            ),
          ),
        );
      }
          // return Center(
          //   child: Text("Something went wrong ! ${state}"),
          // );
          ),
    );
  }
}
