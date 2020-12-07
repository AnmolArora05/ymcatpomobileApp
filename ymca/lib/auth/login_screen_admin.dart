import 'package:flutter/material.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/home_Screen_student.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/admin/home_screen_admin.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/auth/register_screen.dart';
import 'package:ymca/data/rest_url.dart';

class LoginScreenAdmin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginScreenAdminState();
  }
}
class LoginScreenAdminState extends State<LoginScreenAdmin>{



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
        SizedBox(height: 40),
        Image.asset(
          'assets/images/ymca.png',
          height: 120,
        ),


        // Email Edit text
        Container(
          margin: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
          child: TextFormField(

            decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder()
            ),
            minLines: 1,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,

          ),
        ),

        // Password Edit text
        Container(
          margin: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Password",     // Set text upper animation
              border: OutlineInputBorder(),
            ),
            controller: new TextEditingController(),
            minLines: 1,
            autofocus: false,
            keyboardType: TextInputType.text,
            obscureText: true,      // Hiding words
          ),
        ),

        // Login Button
        Center(
            child: Container(
                margin: EdgeInsets.only(top: 50.0),
                child: RaisedButton(
                onPressed: () {
//                    Route route = MaterialPageRoute(builder: (context) => );
//                    Navigator.push(context, route);
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
                        'Admin Login',
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