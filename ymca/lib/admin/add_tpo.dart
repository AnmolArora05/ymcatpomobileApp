import 'package:flutter/material.dart';
import 'package:ymca/admin/home_screen_admin.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ymca/model/TPO.dart';
import 'package:ymca/model/User.dart';

class AddOfficer extends StatefulWidget {
  @override
  AddOfficerState createState() {
    return AddOfficerState();
  }
}

class AddOfficerState extends State<AddOfficer> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String url = RestURl.baselURL + RestURl.createTPOURL;

  RestDataSource rest = new RestDataSource();
  TextEditingController pass = TextEditingController();
  User model = User();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Add a Officer'),
        ),
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
                          labelText: 'Employee Id',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter ID';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.username = value;
                        },
                        keyboardType: TextInputType.number,
                        autofocus: true,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Officer Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.name = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password", // Set text upper animation
                          border: OutlineInputBorder(),
                        ),
                        controller: pass,
                        minLines: 1,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        // Hiding words
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter Password';
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          // Set text upper animation
                          border: OutlineInputBorder(),
                        ),
                        controller: new TextEditingController(),
                        minLines: 1,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter username';
                          if (value != pass.text)
                            return "Password Not Match";
                          else
                            model.password = value;
                          return null;
                        },
                        onSaved: (value) {
                          model.password = value;
                        }, // Hiding words
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Branch',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the branch';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.department = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.phoneNumber = value;
                        },
                        keyboardType: TextInputType.number,
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
                                  setState(() {
                                    _formKey.currentState.reset();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text('New TPO Added')));
                                  });
                                });
                              }
                            }, // When Click on Button goto Login Screen

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