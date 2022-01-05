import 'package:flutter/material.dart';
import 'package:sci_que/Util/Util.dart';
import 'package:sci_que/Views/Home.dart';
// import 'package:sci_que/Views/Splash_screen.dart';
import 'package:sci_que/Widgets/CustomText.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:vibration/vibration.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(40, 37, 97, 1),
        body: Padding(
            padding: EdgeInsets.only(top: 140, left: 30, right: 30),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w700,
                          fontSize: 45),
                    )),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(controller: nameController, label: "User Name"),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    isObscure: true),

                // FlatButton(
                //   onPressed: (){
                //     //forgot password screen
                //   },
                //   textColor: Colors.blue,
                //   child: Text('Forgot Password'),
                // ),

                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 50,
                    // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pinkAccent),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      onPressed: () {
                        this.validate();
                      },
                    )),
              ],
            )));
  }

  //Password Validation
  validate() {
    print(nameController.text);
    print(passwordController.text);
    if (nameController.text == "Navindu" && passwordController.text == "1234") {
      UtilFunctions.navigateTo(context, HOME());
    } else {
      // if (await Vibration.hasVibrator()) {
      //   Vibration.vibrate();
      // }
      Fluttertoast.showToast(
        msg: "Password Incorrect",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
