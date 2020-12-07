import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/home_Screen_student.dart';
import 'package:ymca/model/StudentEducationDetails.dart';

class EducationalDetails extends StatefulWidget {
  @override
  EducationalDetailsState createState() {
    return EducationalDetailsState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class EducationalDetailsState extends State<EducationalDetails> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  RestDataSource rest = RestDataSource();
  String rollNo ;
  String url = RestURl.baselURL + RestURl.updateEducationDetailsURL;
  String getURL = RestURl.baselURL + RestURl.getEducationDetailsURL;
  StudentEducationDetails model = StudentEducationDetails();
  TextEditingController pgCgpa =TextEditingController();
  TextEditingController gradCgpa =TextEditingController();
  TextEditingController sscMarks =TextEditingController();
  TextEditingController hsscMarks =TextEditingController();
  TextEditingController pgPassYear =TextEditingController();
  TextEditingController gradCourse =TextEditingController();
  TextEditingController gapReason =TextEditingController();
  TextEditingController pgCourse =TextEditingController();
  TextEditingController hssStream =TextEditingController();
  TextEditingController sscPassYear =TextEditingController();
  TextEditingController hsscPasYear =TextEditingController();
  TextEditingController gradPassYear =TextEditingController();
  TextEditingController gapYear =TextEditingController();

  Future getData() async{
    SharedPreferences shared = await SharedPreferences.getInstance();
    rollNo = shared.getString("username");
    rest.get(getURL +rollNo).then((dynamic res) {
      if(res['pgCgpa'] != null) {
        pgCourse.text = res['pgCourse'];
        pgCgpa.text = res['pgCgpa'].toString();
        pgPassYear.text = res['pgPassYear'].toString();
        gradCourse.text = res['gradCourse'];
        gradCgpa.text = res['gradsCgpa'].toString();
        gradPassYear.text = res['gradPassYear'].toString();
        sscPassYear.text = res['sscPassYear'].toString();
        sscMarks.text = res['sscMarks'].toString();
        hsscPasYear.text = res['hsscPasYear'].toString();
        hsscMarks.text = res['hsscMarks'].toString();
        hssStream.text = res['hsscStream'].toString();
        if(res['gapYear'] > 0) {
          gapReason.text = res['gapReason'];
          gapYear.text =res['gapYear'].toString();
        }else{
          gapReason.text = 'NA';
          gapYear.text ='0';
        }
        model.id = res['id'];
      }
    });

  }

  @override
  void initState(){
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Educational Details'),
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
                        controller: sscMarks,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '10th Marks',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter marks';
                          }
                          return null;
                        },
                        autofocus: true,
                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.sscMarks = double.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: sscPassYear,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '10th Passing Year ',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid year';
                          }
                          return null;
                        },
                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.sscPassYear = int.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: hsscMarks,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '12th Marks',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid marks';
                          }
                          return null;
                        },
                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.hsscMarks = double.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: hsscPasYear,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '12th Passing Year',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid year';
                          }
                          return null;
                        },
                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.hsscPasYear = int.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: hssStream,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Stream",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid Stream';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.hsscStream = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: gradCourse,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Graduation Course',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid Course';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.gradCourse = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: gradCgpa,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Graduation Marks(%)',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid CGPA';
                          }
                          return null;
                        },
                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.gradsCgpa = double.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: gradPassYear,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Grad Passing year",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid year';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.gradPassYear = int.parse(value);
                        },
                        keyboardType : TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: pgCourse,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'P.G. Course Name',
                        ),

                        onSaved: (value) {
                          model.pgCourse = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: pgPassYear,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'P.G passing year',
                        ),

                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.pgPassYear = int.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: pgCgpa,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'P.G Percentage',
                        ),
                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.pgCgpa = double.parse(value);
                        },
                      ),


                      SizedBox(height: 20),
                      TextFormField(
                        controller: gapYear,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Gap Years(If any)',
                        ),
                        keyboardType : TextInputType.number,
                        onSaved: (value) {
                          model.gapYear = int.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: gapReason,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Gap Reason',
                        ),

                        onSaved: (value) {
                          model.gapReason =value;
                        },
                      ),
                      new Container(
                          margin: EdgeInsets.only(top: 50.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a Snackbar.

                                _formKey.currentState.save();
                                String json = jsonEncode(this.model);
                                rest.post(url+rollNo,body:json).then((dynamic res) {
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(content: Text('Data Saved')));
                                  });
                                });
                              }
                            },

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
                )
            )
        )
    );
  }
}
