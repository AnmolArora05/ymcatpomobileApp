import 'package:flutter/material.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/home_Screen_student.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/auth/login_screen.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/auth/login_screen_admin.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/auth/register_screen.dart';

class UserLogin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return UserLoginState();
  }
}
class UserLoginState extends State<UserLogin>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: initScreen(context),
      )
      ,
    );
  }

  initScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 175),
        Image.asset(
          'assets/images/ymca.png',
          height: 120,
        ),
        // Login Button
        Center(
            child: Container(
                margin: EdgeInsets.only(top: 50.0),
                child: RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) => LoginScreen());
                    Navigator.push(context, route);
                  }, // When Click on Button goto Login Screen

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 300.0, minHeight: 40.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'Login as Student',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )
            )
        ),
        Center(
            child: Container(
                margin: EdgeInsets.only(top: 50.0),
                child: RaisedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) => LoginScreenAdmin());
                    Navigator.push(context, route);
                  }, // When Click on Button goto Login Screen

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))
                    ),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 300.0, minHeight: 40.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'Login as Admin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )
            )
        ),


      ],
    );
  }
}