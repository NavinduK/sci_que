import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilFunctions {
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch coursera.com';
  }
}
