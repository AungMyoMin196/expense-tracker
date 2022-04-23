import 'dart:async';
import 'package:expense_tracker/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void bootstrap(App app) {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(app);
  },
      (Object error, StackTrace stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack));
}
