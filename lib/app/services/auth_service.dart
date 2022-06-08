import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  User? _user;
  List list = [];
  Map<String, dynamic> params = {'str': 'user'};

  static AuthService? _instance;

  AuthService._();

  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
  }

  User? get user {
    return _user;
  }

  bool isAuthenticated() {
    return _user != null;
  }

  bool isUnauthenticated() {
    return !isAuthenticated();
  }

  void setAuthUser(User user) {
    _user = user;
  }

  void removeAuthUser() {
    _user = null;
  }
}
