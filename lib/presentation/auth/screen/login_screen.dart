import 'package:auto_route/auto_route.dart';
import 'package:de_nada/presentation/app_router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/auth_bloc/auth_bloc.dart';
import '../widget/gradient_button.dart';
import '../widget/login_field.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              AutoRouter.of(context).replace(const WeatherRoute());
            }
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
            if (state is SignInFailed) {
              AutoRouter.of(context).push(const ErrorRoute());
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Image.asset('assets/signin_balls.png'),
                  const Text(
                    'Sign In.',
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
                  state is AuthLoading
                      ?
                      // CupertinoActivityIndicator
                      const CupertinoActivityIndicator()
                      : GradientButton(
                          text: "Sign in",
                          onPressed: () {
                            // context.read<AuthBloc>().add(AuthLoginRequested(
                            //     email: emailController.text.trim(),
                            //     password: passwordController.text.trim()));
                            context.read<AuthBloc>().add(SignInEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ));
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => SignUpScreen(),
                      //     ));
                      AutoRouter.of(context).replace(const SignUpRoute());
                      // AutoRouter.of(context).push(SignUpRoute());
                    },
                    child: const Text.rich(
                        TextSpan(text: "Don't have Account ? ", children: [
                      TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              decoration: TextDecoration.underline))
                    ])),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
