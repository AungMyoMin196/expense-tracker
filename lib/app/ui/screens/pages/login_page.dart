// ignore_for_file: lines_longer_than_80_chars

import 'package:expense_tracker/app/blocs/auth/index.dart';
import 'package:expense_tracker/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const String routePath = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.insights,
                  size: 150,
                  color: Colors.white,
                ),
                Text(
                  'EXPENSE TRACKER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              children: [
                const Text(
                  'Using the application as guest, you will not be able to retrieve your data when you once logged out or reinstall the application.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15.0),
                TextButton.icon(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(const GoogleSignInEvent());
                  },
                  icon: const Icon(Icons.shield),
                  label: const Text(
                    'LOG IN WITH GOOGLE',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppTheme.accentColor,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50.0),
                  ),
                ),
                const SizedBox(height: 15.0),
                TextButton.icon(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(const AnonymousSignInEvent());
                  },
                  icon: const Icon(Icons.account_circle),
                  label: const Text(
                    'CONTINUE AS GUEST',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppTheme.accentColor,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
