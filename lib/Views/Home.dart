import 'package:flutter/material.dart';
import 'package:sci_que/Util/Util.dart';
import 'package:url_launcher/url_launcher.dart';

class HOME extends StatefulWidget {
  const HOME({Key? key}) : super(key: key);

  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 37, 97, 1),
      body: ListView(
          padding: EdgeInsets.only(top: 80, left: 40, right: 40),
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'SCI QUE',
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 35),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 6,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Science Quiz with 10 multiple choice questions which can be complete approximately by less than 10 minutes. You can only answer once for every question and press submit button to check the answer.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Tap to start the quiz',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.pinkAccent,
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 50)),
                child: Text(
                  'START',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                ),
                onPressed: () {
                  UtilFunctions.navigateTo(context, HOME());
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Need to learn more?',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 55, right: 55),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30)),
                  child: Text(
                    'Take a Course',
                    style: TextStyle(
                        color: Color.fromRGBO(40, 37, 97, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  onPressed: _launchURL),
            ),
          ]),
    );
  }

  void _launchURL() async {
    if (!await launch('https://www.coursera.org/search?query=science'))
      throw 'Could not launch coursera.com';
  }
}
