import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:sci_que/Util/Util.dart';
import 'package:sci_que/Views/Home.dart';
import 'package:sci_que/Views/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateToLoginPage();
    super.initState();
  }

  void navigateToLoginPage() {
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('user') != null) {
        print(prefs.getString('user'));
        UtilFunctions.navigateTo(
            context, HOME(name: prefs.getString('user') as String));
      } else
        UtilFunctions.navigateTo(context, LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 37, 97, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 250,
                child: BounceInDown(
                  child: Container(
                      width: width,
                      height: 280,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/splash_logo.png'),
                        fit: BoxFit.contain,
                      ))),
                  duration: Duration(milliseconds: 2000),
                )),
            Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 70.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FadeInUp(
                        child: Text(
                      "Powered by",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                    FadeInUp(
                        child: Text(
                      "Navindu Kavishka",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
