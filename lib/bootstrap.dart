import 'dart:async';
import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/app/app_bloc_observer.dart';
import 'package:expense_tracker/blocs/transaction/transaction_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void bootstrap(App app) {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    await BlocOverrides.runZoned(
      () async => runApp(MultiBlocProvider(
        providers: [
          BlocProvider<TransactionBloc>(
            create: (BuildContext context) => TransactionBloc(),
          ),
        ],
        child: app,
      )),
      blocObserver: AppBlocObserver(),
    );
  },
      (Object error, StackTrace stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack));
}
