import 'package:bloc/bloc.dart';
import 'package:de_nada/infrastructure/repositories/auth_repo.dart';
import 'package:de_nada/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<UserAlreadySignedInEvent>(_isUserAlreadySignedIn);
    on<SignInEvent>(_signInUser);
    on<SignUpEvent>(_signUpUser);
    on<LogOutEvent>(_logoutUser);
  }

  final authRepo = serviceLocator.get<AuthRepo>();
  Future<void> _isUserAlreadySignedIn(
      UserAlreadySignedInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      User? _user = authRepo.getCurrentUser();
      if (_user != null) {
        emit(AuthSuccess(_user));
      } else {
        emit(UserNotSignedIn());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
      // emit(WeatherFailure(e.toString()));
    }
  }

  _signInUser(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.signIn(email: event.email, password: event.email);
      User? _user = authRepo.getCurrentUser();
      emit(AuthSuccess(_user!));
    } catch (e) {
     
      emit(AuthFailure(e.toString()));
       emit(SignInFailed());
    }
  }

  _signUpUser(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.signUp(email: event.email, password: event.email);
      User? user = authRepo.getCurrentUser();
      emit(AuthSuccess(user!));
    } catch (e) {
      emit(SignUpFailed());
      emit(AuthFailure(e.toString()));
    }
  }

  _logoutUser(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepo.logOut();
      emit(LogoutState());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
