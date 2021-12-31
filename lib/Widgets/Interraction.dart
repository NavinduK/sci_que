import 'dart:async';
import 'package:flutter/material.dart';

// https://newbedev.com/how-to-execute-a-function-after-a-period-of-inactivity-in-flutter
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  void _initializeTimer() {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(const Duration(seconds: 3), _logOutUser);
  }

  void _logOutUser() {
    _timer?.cancel();
    // _timer = null;

    // Popping all routes and pushing welcome screen
    _navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('welcome', (_) => false);
  }

  void _handleUserInteraction([_]) {
    _initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _handleUserInteraction,
      onPanDown: _handleUserInteraction,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Navigator(
          initialRoute: 'welcome',
          key: _navigatorKey,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(),
                body: SafeArea(child: Text(settings.name as String)),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => Navigator.of(context).pushNamed('test'),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
