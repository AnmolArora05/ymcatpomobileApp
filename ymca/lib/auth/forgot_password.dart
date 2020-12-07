import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  String url = RestURl.baselURL + RestURl.resetPasswordURL;
  final _formKey = GlobalKey<FormState>();
  RestDataSource rest = RestDataSource();
  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Container(
                    margin: EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 150),
                        Image.asset(
                          'assets/images/ymca.png',
                          height: 120,
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                              labelText: "Roll Number", border: OutlineInputBorder()),
                          minLines: 1,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          validator: (value) {
                            if (value.isEmpty) return 'Please enter username';
                            return null;
                          },
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

                                      rest
                                          .post(url + username.text)
                                          .then((dynamic response) {
                                        print(response['message']);
                                        if (response['message'] == 'Success') {
                                          setState(() {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Temporary password has been sent to your mail id')));
                                          });
                                        }
                                      });
                                    }
                                  }, // When Click on Button goto Login Screen

                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          maxWidth: 300.0, minHeight: 40.0),
                                      // min sizes for Material buttons
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Reset Password',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ))),
                      ],
                    )))));
  }
}
