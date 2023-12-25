// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent {}

class SignUpEvent extends AuthEvent {
  String email;
  String password;
  SignUpEvent({
    required this.email,
    required this.password,
  });
}

class SignInEvent extends AuthEvent {
  String email;
  String password;
  SignInEvent({
    required this.email,
    required this.password,
  });
}

class UserAlreadySignedInEvent extends AuthEvent {}
class LogOutEvent extends AuthEvent {}
