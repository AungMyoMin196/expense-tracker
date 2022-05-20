import 'package:expense_tracker/app/ui/routes/app_router.dart';
import 'package:expense_tracker/app/ui/screens/pages/home_page.dart';
import 'package:expense_tracker/themes/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final String flavor;

  const App({Key? key, required this.flavor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanse Tracker',
      theme: AppTheme.light,
      initialRoute: HomePage.routePath,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
