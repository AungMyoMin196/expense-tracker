import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class CheckAuthEvent extends AuthEvent {
  final User? auth;

  const CheckAuthEvent(this.auth);

  @override
  String toString() => 'CheckAuthEvent';
}

class GoogleSignInEvent extends AuthEvent {
  const GoogleSignInEvent();

  @override
  String toString() => 'GoogleSignInEvent';
}

class AnonymousSignInEvent extends AuthEvent {
  const AnonymousSignInEvent();

  @override
  String toString() => 'AnonymousSignInEvent';
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();

  @override
  String toString() => 'SignOutEvent';
}
