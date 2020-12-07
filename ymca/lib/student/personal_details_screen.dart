import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/home_Screen_student.dart';
import 'package:ymca/model/StudentPersonalDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonalDetails extends StatefulWidget {

  String role;
  String token;
  String username;
  String email;

  PersonalDetails(String token, String role, String username,String email) {
    this.token = token;
    this.role = role;
    this.username = username;
    this.email =email;
    future();
  }
  PersonalDetails.name();

  Future future() async {
    print("*******************************" + this.role);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", this.email);
    sp.setString("role", this.role);
    sp.setString("username", this.username);
    sp.setString("token", this.token);

    return null;
  }

  @override
  PersonalDetailsState createState() {
    return PersonalDetailsState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class PersonalDetailsState extends State<PersonalDetails> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  String url = RestURl.baselURL + RestURl.personalDetailsURL ;
  String savePersonalDetails = RestURl.baselURL + RestURl.savePersonalDetailsURL;
  //String rollNo = RestURl.rollNo;
  RestDataSource rest = new RestDataSource();
  StudentPersonalDetails model = StudentPersonalDetails();
  TextEditingController rc =TextEditingController();
  TextEditingController motherName =TextEditingController();
  TextEditingController gender =TextEditingController();
  TextEditingController city =TextEditingController();
  TextEditingController state =TextEditingController();
  TextEditingController fullName =TextEditingController();
  TextEditingController fatherName =TextEditingController();
  TextEditingController address =TextEditingController();
  TextEditingController pin =TextEditingController();
  TextEditingController dob =TextEditingController();
  TextEditingController emailCon =TextEditingController();
  TextEditingController contactName =TextEditingController();



  @override
  void initState(){
    super.initState();
    getData();
  }
  Future getData() async{
    SharedPreferences shared = await SharedPreferences.getInstance();
    String rollNo = shared.getString("username");
    String email = shared.getString("email");
    emailCon.text = email;
    rc.text = rollNo;
    rest.get(url + rollNo).then((dynamic res) {
      if(res['motherName'] != null) {
        city.text = res['city'];
        state.text = res['state'];
        contactName.text = res['contactNo'];
        dob.text = res['dob'];
        motherName.text = res['motherName'];
        gender.text = res['gender'].toString();
        fullName.text = res['fullName'];
        fatherName.text = res['fatherName'];
        address.text = res['address'];
        pin.text = res['zipCode'].toString();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Personal Details'),
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
                    controller: rc,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Roll Number',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Roll Number';
                      }
                      return null;
                    },
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      model.rollNo = value;
                    },
                    enabled: false,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: dob,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'DOB (DD-MM-YYYY)',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.dob = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: fullName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Full Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.fullName = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: emailCon,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Email';
                      }
                      return null;
                    },
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      model.email =value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: fatherName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Father's Name",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.fatherName = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: motherName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mother's Name",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.motherName = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: gender,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Gender",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid gender';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.gender = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: contactName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.contactNo = value;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid Address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.address = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: pin,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'PIN Code',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid PIN Code';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      model.zipCode = int.parse(value);
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: city,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid City';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.city = value;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: state,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'State',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter valid State';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      model.state =value;
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
                             rest.post(savePersonalDetails,body:json).then((dynamic res) {
                               setState(() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text('Data Saved')));
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
                            constraints: const BoxConstraints(maxWidth: 100.0, minHeight: 40.0), // min sizes for Material buttons
                            alignment: Alignment.center,
                                    child: const Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ))));
  }
}
