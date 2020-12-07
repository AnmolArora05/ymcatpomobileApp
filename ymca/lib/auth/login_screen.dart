
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/admin/home_screen_admin.dart';
import 'package:ymca/admin/show_tpo-details.dart';
import 'package:ymca/auth/forgot_password.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/auth/register_screen.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';
import 'package:ymca/model/User.dart';
import 'package:ymca/student/home_Screen_student.dart';
import 'package:ymca/student/personal_details_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}
 class LoginScreenState extends State<LoginScreen>{

   String url = RestURl.baselURL + RestURl.authenticateURL;
   final _formKey = GlobalKey<FormState>();
   User user =User();
  RestDataSource rest = RestDataSource();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: SingleChildScrollView(
         child: initScreen(context),
       )
     );
   }

   initScreen(BuildContext context) {
     return Form(
           key: _formKey,
           child : Container(

              margin: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:30),
                  Image.asset(
                    'assets/images/ymca_back_cover.jpg',
                    height: 250,
                  ),
                  SizedBox(height:30),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        labelText: "User ID",
                        border: OutlineInputBorder()
                    ),
                    minLines: 1,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter Roll Number';
                      return null;
                    },
                    onSaved: (value){
                        user.username = value;
                    },
                  ),
                  SizedBox(height:30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password", // Set text upper animation
                      border: OutlineInputBorder(),
                    ),
                    controller: password,
                    minLines: 1,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Please enter password';
                      return null;
                    },
                    onSaved: (value){
                      user.password = value;
                    },// Hiding words
                  ),
                  Center(
                      child: Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: RaisedButton(
                            onPressed: () {
                              bool isAuthenticated = false;
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.

                                _formKey.currentState.save();
                                String json = jsonEncode(this.user);
                                rest.post(url,body:json).then((dynamic response) {
                                  print(response['token']);
                                  if(response['token'] != null && response['role'] == 'Student'){
                                      Route route = MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalDetails(response['token'],response['role'],response['username'],response['email']));
                                      Navigator.pushReplacement(context, route);
                                    }else if(response['token'] != null && response['role'] == 'Admin'){
//
                                      Route route = MaterialPageRoute(
                                          builder: (context) =>
                                              TpoDetails(response['token'],response['role'],response['username']));
                                      Navigator.pushReplacement(context, route);
                                    }else if(response['message'] == 'INVALID_CREDENTIALS')
                                        setState(() {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(content: Text('Wrong Credentials')));
                                        });

                                });
                              }
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
                                  'Log in',
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
                          padding: EdgeInsets.only(bottom: 30.0),
                          margin: EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                child: Text(
                                  "Forgot Password ? ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword()));
                                },
                              ),
                              GestureDetector(
                                child: Text(
                                  "  Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                                },
                              )
                            ],
                          )
                      )
                  )



                ],
              )
           )
     );
   }
 }