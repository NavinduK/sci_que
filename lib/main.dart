import 'package:flutter/material.dart';
// import 'Views/LoginPage.dart';
import 'Views/Splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.pink, hintColor: Colors.white),
        home: SplashScreen());
  }
}
