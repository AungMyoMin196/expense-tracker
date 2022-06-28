import 'package:expense_tracker/app/blocs/auth/index.dart';
import 'package:expense_tracker/app/blocs/blocs.dart';
import 'package:expense_tracker/app/ui/routes/app_router.dart';
import 'package:expense_tracker/app/ui/screens/pages/login_page.dart';
import 'package:expense_tracker/app/ui/screens/root.dart';
import 'package:expense_tracker/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class App extends StatelessWidget {
  final String name;

  const App({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Container(
            color: AppTheme.primaryColor,
            child: const Center(
              child: CircularProgressIndicator(color: AppTheme.accentColor),
            ),
          );
        }
        if (state is AuthenticatedState) {
          return MultiBlocProvider(
            providers: Blocs.provideAuthenticatedLevel(),
            child: MaterialApp(
              title: name,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              supportedLocales: const [
                Locale('en'),
              ],
              localizationsDelegates: const [
                ...GlobalMaterialLocalizations.delegates,
                GlobalWidgetsLocalizations.delegate,
                FormBuilderLocalizations.delegate,
              ],
              home: const Root(),
              onGenerateRoute: AppRouter.authenticatedGenerateRoute,
            ),
          );
        }
        return MaterialApp(
          title: name,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          onGenerateRoute: AppRouter.unauthenticatedGenerateRoute,
          home: const LoginPage(),
        );
      },
    );
  }
}
