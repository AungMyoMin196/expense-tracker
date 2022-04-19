import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final String flavor;

  const App({Key? key, required this.flavor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanse Tracker',
      home: Scaffold(
        appBar: AppBar(title: Text(flavor)),
        body: Center(
          child: TextButton(
            child: const Text('Crash Report'),
            onPressed: () => {FirebaseCrashlytics.instance.crash()},
          ),
        ),
      ),
    );
  }
}
