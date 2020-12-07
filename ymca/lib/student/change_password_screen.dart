import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';
import 'package:ymca/model/ChangePassword.dart';
import 'package:ymca/student/home_Screen_student.dart';

class ChangePasswordStudent extends StatefulWidget {
  @override
  ChangePasswordStudentState createState() {
    return ChangePasswordStudentState();
  }
}

class ChangePasswordStudentState extends State<ChangePasswordStudent> {
  final _formKey = GlobalKey<FormState>();
  RestDataSource rest = RestDataSource();
  TextEditingController pass = TextEditingController();
  String username;
  ChangePasswordModel model = ChangePasswordModel();
  String url = RestURl.baselURL + RestURl.changePasswordURL;

  Future getUsername() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    this.model.username = username;
    return null;
  }

  void initState(){
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(title: Text('Change Password')),
        body: Form(
            key: _formKey,
            child: Container(
                margin: EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Old Password',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        autofocus: true,
                        obscureText: true,
                        onSaved: (value) {
                          model.prevPassword = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: pass,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New Password',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter new password';
                          }
                          return null;
                        },
                        obscureText: true,
                        onSaved: (value) {

                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid password';
                          }else if(pass.text != value )
                            return "Password not Matched";
                          return null;
                        },
                        obscureText: true,
                        onSaved: (value) {
                          model.newPassword =value;
                        },
                      ),
                      SizedBox(height: 20),
                      new Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.

                                _formKey.currentState.save();
                                String json = jsonEncode(this.model);
                                rest.post(url, body: json).then((dynamic res) {
                                  if(res['message'] == 'Success') {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                              content: Text('Password Changed')));
                                    });
                                    _formKey.currentState.reset();
                                  }else if(res['message'] == 'Invalid Password') {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                              content: Text('Invalid Password')));
                                    });
                                  } else {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          SnackBar(
                                              content: Text('Error Occurred,Try Again')));
                                    });
                                  }
                                });
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: const EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        new Color(0xff374ABE),
                                        new Color(0xff64B6FF)
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                              child: Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 100.0, minHeight: 40.0),
                                // min sizes for Material buttons
                                alignment: Alignment.center,
                                child: const Text(
                                  'Submit',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ))));
  }
}