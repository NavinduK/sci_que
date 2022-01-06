import 'package:flutter/material.dart';
import 'package:sci_que/Util/Util.dart';
import 'package:sci_que/Views/Question.dart';
import 'package:sci_que/Views/Splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HOME extends StatefulWidget {
  const HOME({
    Key? key,
    this.name = '',
  }) : super(key: key);
  final String name;

  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 37, 97, 1),
      body: ListView(
          padding: EdgeInsets.only(top: 30, left: 40, right: 40),
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
                    'Science Quiz with 10 multiple choice questions which can be complete approximately by less than 10 minutes. You can only answer once for every question and press submit button to check the answer after completing each question.',
                    style: TextStyle(color: Colors.white, fontSize: 19),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Tap to start the quiz',
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
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
                  UtilFunctions.navigateTo(context, Question());
                },
              ),
            ),
            SizedBox(
              height: 20,
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
                      primary: Colors.white.withOpacity(0.8),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
                  child: Text(
                    'Take a Course',
                    style: TextStyle(
                        color: Color.fromRGBO(40, 37, 97, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  onPressed: () => UtilFunctions.launchURL(
                      'https://www.coursera.org/search?query=science')),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              'Logged as : ' + widget.name,
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Double Tap To Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                  height: 50,
                  width: 50,
                  child: GestureDetector(
                    onDoubleTap: () async {
                      print('logout done!');
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('user');
                      UtilFunctions.navigateTo(context, SplashScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.logout_sharp,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ),
          ]),
    );
  }
}
