import 'package:flutter/material.dart';
import 'package:sci_que/Util/Util.dart';
import 'package:sci_que/Views/Home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sci_que/Widgets/CustomText.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sci_que/Widgets/ScaffoldWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vibration/vibration.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

// void main(List<String> args, BuildContext context) {
//   GetStorage box = GetStorage();
//   if (box.read('session_uname') != '' || box.read('session_uname') != null)
//     UtilFunctions.navigateTo(context, HOME());
// }

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        app: AppBar(),
        body: Container(
            child: Padding(
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
                    style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
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
          ),
        )));
  }

  //Password Validation
  validate() async {
    print(nameController.text);
    print(passwordController.text);
    if (nameController.text == "Navindu" && passwordController.text == "1234") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('user', nameController.text);
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
