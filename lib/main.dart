import 'package:flutter/material.dart';
import 'Views/Splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(40, 37, 97, 1),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          color: Color.fromRGBO(40, 37, 97, 1),
          theme: ThemeData(
              primarySwatch: Colors.pink,
              hintColor: Colors.white,
              scaffoldBackgroundColor: Color.fromRGBO(40, 37, 97, 1)),
          home: SplashScreen()),
    );
  }
}
