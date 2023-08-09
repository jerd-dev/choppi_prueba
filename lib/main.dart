import 'package:choppi_prueba/config/router/app_router.dart';
import 'package:choppi_prueba/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  runApp(const MainApp());


}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,

    );
  }
}
