
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';
import 'package:ymca/model/User.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}
class RegisterScreenState extends State<RegisterScreen>{

  User user  = User();
  TextEditingController pass = TextEditingController();
  RestDataSource rest = RestDataSource();
  String url = RestURl.baselURL + RestURl.registerURL;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: initScreen(context),
      )
      ,
    );
  }

  initScreen(BuildContext context) {

    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30),
            Image.asset(
              'assets/images/ymca.png',
              height: 100,
            ),
            // Email Edit text
            SizedBox(height:30),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Roll Number", border: OutlineInputBorder()),
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
                  labelText: "Name", border: OutlineInputBorder()),
              minLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              validator: (value) {
                if (value.isEmpty)
                  return 'Please enter Name';
                return null;
              },
              onSaved: (value){
                user.name = value;
              },
            ),
            SizedBox(height:30),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Email", border: OutlineInputBorder()),
              minLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              validator: (value) {
                if (value.isEmpty)
                  return 'Please enter valid Email';
                return null;
              },
              onSaved: (value){
                user.email = value;
              },
            ),
            SizedBox(height:30),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password", // Set text upper animation
                border: OutlineInputBorder(),
              ),
              controller: pass,
              minLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              obscureText: true, // Hiding words
              validator: (value) {
                if (value.isEmpty)
                  return 'Please enter Password';
                return null;
              },


            ),
            SizedBox(height:30),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirm Password", // Set text upper animation
                border: OutlineInputBorder(),
              ),
              controller: new TextEditingController(),
              minLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty)
                  return 'Please enter username';
                if(value != pass.text)
                  return "Password Not Match";
                else
                  user.password = value;
                return null;
              },
              onSaved: (value){
                user.password = value;
              },// Hiding words
            ),
            SizedBox(height:30),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Department", // Set text upper animation
                border: OutlineInputBorder(),
              ),
              controller: new TextEditingController(),
              minLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              obscureText: false,
              validator: (value) {
                if (value.isEmpty)
                  return 'Please enter Department';
                return null;
              },
              onSaved: (value){
                user.department = value;
              },
              // Hiding words
            ),
            SizedBox(height:30),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Phone Number", // Set text upper animation
                border: OutlineInputBorder(),
              ),
              controller: new TextEditingController(),
              minLines: 1,
              autofocus: false,
              keyboardType: TextInputType.number,
              obscureText: false,
              validator: (value) {
                if (value.isEmpty)
                  return 'Please enter valid number';
                return null;
              },
              onSaved: (value){
                user.phoneNumber = value;
              },
            ),

            // Login Button
            Center(
                child: Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.

                          _formKey.currentState.save();
                          String json = jsonEncode(this.user);
                          rest
                              .post(url, body: json)
                              .then((dynamic response) {
                            if (response['message'] == 'Success') {
                              _formKey.currentState.reset();
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        'Registration Successfull')));
                              });
                            }else{
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(
                                        'Error Occurred')));
                              });
                            }
                          });
                              // Route route = MaterialPageRoute(builder: (context) => HomeScreen());
                              //Navigator.push(context, route);
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
                              maxWidth: 300.0, minHeight: 40.0),
                          // min sizes for Material buttons
                          alignment: Alignment.center,
                          child: const Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}