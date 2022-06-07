import 'package:bloc/bloc.dart';
import 'package:expense_tracker/app/blocs/auth/auth_event.dart';
import 'package:expense_tracker/app/blocs/auth/auth_state.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'dart:developer' as developer;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthLoadingState()) {
    _authRepository.checkAuthStateChanges().listen((event) {
      add(CheckAuthEvent(event));
    });

    on<CheckAuthEvent>((event, emit) async {
      if (event.auth != null) {
        emit(AuthenticatedState(auth: event.auth!));
      } else {
        emit(const UnAuthenticatedState());
      }
    });
    on<GoogleSignInEvent>((event, emit) async {
      try {
        emit(const AuthLoadingState());
        await _authRepository.signInWithGoogle();
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(AuthErrorState(e.toString()));
      }
    });
    on<AnonymousSignInEvent>((event, emit) async {
      try {
        emit(const AuthLoadingState());
        await _authRepository.signInAnonymously();
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(AuthErrorState(e.toString()));
      }
    });
    on<SignOutEvent>((event, emit) async {
      try {
        emit(const AuthLoadingState());
        await _authRepository.signOut();
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(AuthErrorState(e.toString()));
      }
    });
  }
}
