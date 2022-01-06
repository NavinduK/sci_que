import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    Key? key,
    required this.body,
    required this.app,
  }) : super(key: key);
  final Container body;
  final AppBar app;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
          appBar: app.backgroundColor != null ? app : null,
          body: Center(
            child: SizedBox(
              child: body,
              width: 450,
            ),
          ));
    }
    return Scaffold(
      appBar: app.backgroundColor != null ? app : null,
      body: body,
    );
  }
}
