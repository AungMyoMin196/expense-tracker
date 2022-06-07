import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();

  @override
  String toString() => 'AuthLoadingState';
}

class CheckAuthState extends AuthState {
  const CheckAuthState();

  @override
  String toString() => 'CheckAuthState';
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState({required this.auth});

  final User auth;

  @override
  String toString() => 'AuthenticatedState';

  @override
  List<Object> get props => [auth];
}

class UnAuthenticatedState extends AuthState {
  const UnAuthenticatedState();

  @override
  String toString() => 'UnAuthenticatedState';
}

class AuthErrorState extends AuthState {
  const AuthErrorState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'AuthErrorState';

  @override
  List<Object> get props => [errorMessage];
}
