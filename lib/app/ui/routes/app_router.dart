import 'package:expense_tracker/app/ui/screens/pages/home_page.dart';
import 'package:expense_tracker/app/ui/screens/pages/login_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routePath:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case LoginPage.routePath:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
