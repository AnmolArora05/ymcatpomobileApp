import 'package:flutter/material.dart';
import 'package:ymca/admin/home_screen_admin.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ymca/model/Company.dart';

class AddCompany extends StatefulWidget {
  @override
  AddCompanyState createState() {
    return AddCompanyState();
  }
}

// Create a corresponding State class, which holds data related to the form.
class AddCompanyState extends State<AddCompany> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  String url = RestURl.baselURL + RestURl.createCompanyURL ;
  RestDataSource rest = new RestDataSource();
  Company model = Company();

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Add a Company'),
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
                          labelText: 'Company Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.companyName = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Job Profile',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the profile';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.jobProfile = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Job Package',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the package';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.jobPackage = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Job Description',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the description';
                          }
                          return null;
                        },
                        minLines: 1,
                        maxLines: 8,
                        onSaved: (value) {
                          model.jobDescription = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number of Vacancies',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the vacancies number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          model.noOfVacancies =int.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Eligibility Criteria",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the eligibility criteria';
                          }
                          return null;
                        },
                        minLines: 1,
                        maxLines: 8,
                        onSaved: (value) {
                          model.eligibilityCriteria = value;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "BackLog's Allow ",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the number of backlogs';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          bool val = value == 'true';
                          model.backlog_Allow = val;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Number of Backlog",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the number of backlog if any';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          model.noOfBacklog = int.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Batch Year',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the batch year';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          model.batchYear = int.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(

                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Last Date Apply (DD/MM/YYYY)',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid valid';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          model.lastDateApply = value;
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
                                rest.post(url,body:json).then((dynamic res) {
                                  if(res['message'] == 'Success') {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                          content: Text('Data Saved')));
                                    });
                                  }else if(res['message'].toString().contains('error')){
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                          content: Text('Error Occurred , Please try Again')));
                                    });
                                  }
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
                                  'Submit',
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
