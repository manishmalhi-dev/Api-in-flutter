import 'package:flutter/material.dart';
import 'package:flutter_apis/app%20routes/routers.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // theme: ThemeData.dark(),
      theme: ThemeData(
        fontFamily: "font01",
      ),
      debugShowCheckedModeBanner: false,
        routerConfig: routes,
    );
  }
}
