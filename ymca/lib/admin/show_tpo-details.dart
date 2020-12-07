import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/admin/home_screen_admin.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';
import 'package:http/http.dart' as http;
import 'package:ymca/model/ChangePassword.dart';
import 'package:ymca/model/TPO.dart';
import 'package:ymca/model/User.dart';
import 'package:ymca/student/certification_screen.dart';

class TpoDetails extends StatefulWidget {
  String token;
  String role;
  String username;

  TpoDetails(String token, String role, String username) {
    this.token = token;
    this.role = role;
    this.username = username;
    future();
  }

  TpoDetails.name();

  Future future() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("role", this.role);
    sp.setString("token", this.token);
    sp.setString("username", this.username);

    return null;
  }

  @override
  TpoDetailState createState() {
    // TODO: implement createState
    return TpoDetailState();
  }
}

Future<User> get() async {
  SharedPreferences share = await SharedPreferences.getInstance();
  String username = share.getString("username");
  String url = RestURl.baselURL + RestURl.getTPOURL + username;
  final response =
      await http.get(url, headers: {"Content-Type": "application/json"});
  debugPrint(response.body);
  return compute(parsePhotos, response.body);
}

User parsePhotos(String responseBody) {
  return User.fromJson(jsonDecode(responseBody));
}

class TpoDetailState extends State<TpoDetails> {
  User tpo;
  RestDataSource rest = RestDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Admin Details'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'Change Password':
                    Route route = MaterialPageRoute(
                        builder: (context) => ChangePassword());
                    Navigator.push(context, route);
                    break;
                  case 'Edit Personal Details':
                    Route route = MaterialPageRoute(
                        builder: (context) => EditDetails(tpo: this.tpo));
                    Navigator.push(context, route);
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Change Password', 'Edit Personal Details'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: FutureBuilder<User>(
          future: get(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Container(
                  child: Center(
                child: Text('No Data'),
              ));
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.hasData && snapshot.data != null)
              return detailsView(snapshot.data);
            else
              return Container(
                  child: Center(
                child: Text('No Data'),
              ));
          },
        ));
  }

  void handleClick(String value) {
    switch (value) {
      case 'View Certificates':
        Route route =
            MaterialPageRoute(builder: (context) => ViewCertifications());
        Navigator.push(context, route);
        break;
      case 'Add a Certificate':
        Route route = MaterialPageRoute(builder: (context) => Certifications());
        Navigator.push(context, route);
        break;
    }
  }

  Widget detailsView(User data) {
    this.tpo = data;
    return Container(
      margin: EdgeInsets.fromLTRB(30, 50, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              child: Row(
            children: <Widget>[
              Text(
                'Name:     ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                data.name,
                style: TextStyle(fontSize: 20),
              ),
            ],
          )),
          SizedBox(height: 20),
          Container(
              child: Row(
            children: <Widget>[
              Text(
                'Email: ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                data.email,
                style: TextStyle(fontSize: 15),
              ),
            ],
          )),
          SizedBox(height: 20),
          Container(
              child: Row(
            children: <Widget>[
              Text(
                'Department:   ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                data.department,
                style: TextStyle(fontSize: 20),
              ),
            ],
          )),
          SizedBox(height: 20),
          Container(
              child: Row(
            children: <Widget>[
              Text(
                'Phone No:   ',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                data.phoneNumber,
                style: TextStyle(fontSize: 20),
              ),
            ],
          )),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class EditDetails extends StatefulWidget {
  User tpo;

  EditDetails({Key key, this.tpo}) : super(key: key);

  @override
  EditDetailState createState() {
    // TODO: implement createState
    return EditDetailState();
  }
}

class EditDetailState extends State<EditDetails> {
  final _formKey = GlobalKey<FormState>();
  User model = User();
  String url = RestURl.baselURL + RestURl.updateTPOURL;
  RestDataSource rest = RestDataSource();
  TextEditingController empId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    empId.text = this.widget.tpo.username.toString();
    name.text = this.widget.tpo.name;
    email.text = this.widget.tpo.email;
    branch.text = this.widget.tpo.department;
    phone.text = this.widget.tpo.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Personal Details'),
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
                        controller: empId,
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
                        readOnly: true,
                        onSaved: (value) {
                          model.username = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.name = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.email = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: branch,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Branch'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.department = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.phoneNumber = value;
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
                                rest
                                    .post(url + empId.text, body: json)
                                    .then((dynamic res) {
                                  setState(() {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Data Saved')));
                                  });
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

class ChangePassword extends StatefulWidget {
  @override
  ChangePasswordState createState() {
    return ChangePasswordState();
  }
}

class ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  RestDataSource rest = RestDataSource();
  TextEditingController pass = TextEditingController();
  String username;
  ChangePasswordModel model = ChangePasswordModel();
  String url = RestURl.baselURL + RestURl.changePasswordURL;

  Future getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    this.model.username = username;
    return null;
  }

  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onSaved: (value) {},
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid password';
                          } else if (pass.text != value)
                            return "Password not Matched";
                          return null;
                        },
                        obscureText: true,
                        onSaved: (value) {
                          model.newPassword = value;
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
                                  if (res['message'] == 'Success') {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Password Changed')));
                                    });
                                    _formKey.currentState.reset();
                                  } else if (res['message'] ==
                                      'Invalid Password') {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Invalid Password')));
                                    });
                                  } else {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Error Occurred,Try Again')));
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
