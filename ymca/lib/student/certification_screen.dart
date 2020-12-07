

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/data/rest_api.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/home_Screen_student.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/opportunities_screen.dart';
import 'package:ymca/data/rest_url.dart';
import 'package:ymca/model/Certificate.dart';
import 'package:http/http.dart' as http;

class Certifications extends StatefulWidget {
  @override
  CertificationsState createState() {
    return CertificationsState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class CertificationsState extends State<Certifications> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String updateURL = RestURl.baselURL + RestURl.updateCertificationDetailsURL;
  TextEditingController certificateName = TextEditingController();
  TextEditingController certificateIssueDate = TextEditingController();
  TextEditingController certificateOrganisation = TextEditingController();
  Certificate certificate = new Certificate();
  RestDataSource rest = new RestDataSource();
  String username;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  Future getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    print(username);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Certifications'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'View Certificates', 'Add a Certificate'}
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
                        controller: certificateName,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Certificate Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          certificate.certiTitle = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: certificateOrganisation,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Organization',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          certificate.orgiDetails = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: certificateIssueDate,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Issue Date'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          certificate.issueDate = value;
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
                                String json = jsonEncode(this.certificate);
                                rest
                                    .post(updateURL + username, body: json)
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
}

Future<List<Certificate>> get() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String username = pref.getString("username");
  String url = RestURl.baselURL + RestURl.getCertificationDetailsURL + username;
  final response =
      await http.get(url, headers: {"Content-Type": "application/json"});
  return compute(parsePhotos, response.body);
}

List<Certificate> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Certificate>((json) => Certificate.fromJson(json)).toList();
}

class ViewCertifications extends StatelessWidget {
  final RestDataSource restDataSource = new RestDataSource();
  final String url =
      RestURl.baselURL + RestURl.getCertificationDetailsURL + RestURl.rollNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Certifications'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {
                switch (value) {
                  case 'View Certificates':
                    Route route = MaterialPageRoute(
                        builder: (context) => ViewCertifications());
                    Navigator.push(context, route);
                    break;
                  case 'Add a Certificate':
                    Route route = MaterialPageRoute(
                        builder: (context) => Certifications());
                    Navigator.push(context, route);
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'View Certificates', 'Add a Certificate'}
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
        body: Container(
          child: FutureBuilder<List<Certificate>>(
            // ignore: missing_return
            future: get(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Container(
                    child: Center(
                  child: Text('No Data'),
                ));
              else if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else if (snapshot.hasData)
                return CertificateList(cert: snapshot.data);
              else
                return Container(
                    child: Center(
                  child: Text('No Data'),
                ));
            },
          ),
        ));
  }
}

class CertificateList extends StatefulWidget {
  final List<Certificate> cert;

  CertificateList({Key key, this.cert}) : super(key: key);

  @override
  CertificateListState createState() {
    return CertificateListState();
  }
}

class CertificateListState extends State<CertificateList> {
  int length;
  bool isVisible = true;
  int _currentIndex = -1;
  List<bool> visibility;
  RestDataSource rest = RestDataSource();
  String deleteUrl = RestURl.baselURL + RestURl.deleteCertificationDetailsURL;

  @override
  void initState() {
    super.initState();
    visibility = List<bool>.generate(this.widget.cert.length, (i) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ListView.builder(
      itemCount: this.widget.cert.length,
      itemBuilder: (context, index) {
        if (this.widget.cert.length == 0)
          return ViewCertifications();
        else {
          return Card(
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              title: Text(
                '${this.widget.cert[index].certiTitle}',
                softWrap: true,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              key: UniqueKey(),
              onTap: () {
                print("*****************************************" +
                    index.toString());
                if (_currentIndex >= 0 && _currentIndex != index) {
                  setState(() {
                    visibility[_currentIndex] = !visibility[_currentIndex];
                    visibility[index] = !visibility[index];
                  });
                } else {
                  setState(() {
                    visibility[index] = !visibility[index];
                  });
                }
                _currentIndex = index;
              },
              subtitle: visibility[index]
                  ? subTitle(index, this.widget.cert[index])
                  : null,
            ),
          );
        }
      },
    );
  }

  Widget subTitle(int index, Certificate cert) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Row(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => EditCertificate(cert));
                Navigator.push(context, route);
              },
              // When Click on Button goto Login Screen
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.all(0.0),
              color: new Color(0xff64B6FF),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 40.0,
                  minHeight: 20.0,
                ),
                // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 30),
            RaisedButton(
              onPressed: () {
                rest
                    .delete(deleteUrl + cert.certificateId.toString())
                    .then((dynamic res) {});
                setState(() {
                  this.widget.cert.removeAt(index);
                });
              },
              // When Click on Button goto Login Screen
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: const EdgeInsets.all(0.0),
              color: new Color(0xff64B6FF),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 40.0,
                  minHeight: 20.0,
                ),
                // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Delete',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}

class EditCertificate extends StatelessWidget {
  Certificate certificate;
  String username;
  final _formKey = GlobalKey<FormState>();
  RestDataSource rest = RestDataSource();
  String url = RestURl.baselURL + RestURl.getCertificationDetailsURL;

  EditCertificate(Certificate certificate) {
    this.certificate = certificate;
    getUsername();
  }

  Future getUsername() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    username = share.getString("username");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Certificate'),
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
                        initialValue: certificate.certiTitle,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Certificate Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          certificate.certiTitle = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: certificate.orgiDetails,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Organization',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          certificate.orgiDetails = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: certificate.issueDate,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Issue Date'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid date';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          certificate.issueDate = value;
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
                                String json = jsonEncode(this.certificate);
                                rest
                                    .put(url + username, body: json)
                                    .then((dynamic res) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Data Updated')));
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
