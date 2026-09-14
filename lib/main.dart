import 'package:flutter/material.dart';
import 'package:flutter_apis/app%20routes/routers.dart';
import 'package:flutter_apis/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: "font01",
      ),

      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "font01",
      ),

      // Provider se theme mode
      themeMode: themeProvider.themeMode,

      routerConfig: routes,
    );
  }
}