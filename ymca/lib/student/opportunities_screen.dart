import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/data/rest_api.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/home_Screen_student.dart';
import 'package:ymca/data/rest_url.dart';
import 'package:ymca/model/Company.dart';
import 'package:http/http.dart' as http;

class Opportunities extends StatefulWidget {
  @override
  OpportunitiesState createState() {
    return OpportunitiesState();
  }
}

class OpportunitiesState extends State<Opportunities> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Opportunities'),
            bottom: TabBar(
              tabs: [Tab(text: "View All"), Tab(text: "Applied")],
              labelColor: Colors.black,
            ),
          ),
          body: TabBarView(
            children: [
              CompaniesList(),
              Applied(),
            ],
          ),
          drawer: NavDrawer(),
        ),
      ),
    );
  }
}
String username;
Future<List<Company>> get(String url) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  username = pref.getString("username");
  if (url.contains("getListCompany")) {
    url = url + username;
  }

  final response =
      await http.get(url, headers: {"Content-Type": "application/json"});
  return compute(parsePhotos, response.body);
}

List<Company> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Company>((json) => Company.fromJson(json)).toList();
}

class Applied extends StatefulWidget {
  @override
  AppliedState createState() {
    return AppliedState();
  }
}

class AppliedState extends State<Applied> {
  String url = RestURl.baselURL + RestURl.getAppliedURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Company>>(
        future: get(url),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Container(
                child: Center(
              child: Text('No Data'),
            ));
          else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasData)
            return listBuilder(snapshot.data);
          else
            return Container(
                child: Center(
              child: Text('No Date'),
            ));
        },
      ),
    );
  }

  Widget listBuilder(List<Company> comp) {
    return ListView.builder(
      itemCount: comp.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: Text(
              comp[index].companyName,
              softWrap: true,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            key: UniqueKey(),
            subtitle: Text('Job Profile : ' + comp[index].jobProfile),
          ),
        );
      },
    );
  }
}

class CompaniesList extends StatefulWidget {
  @override
  CompaniesListState createState() {
    return CompaniesListState();
  }
}

class CompaniesListState extends State<CompaniesList> {
  String url = RestURl.baselURL + RestURl.getCompanyListURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Company>>(
        future: get(url),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Container(
                child: Center(
              child: Text('No Data'),
            ));
          else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasData)
            return listBuilder(snapshot.data);
          else
            return Container(
                child: Center(
              child: Text('No Date'),
            ));
        },
      ),
    );
  }

  Widget listBuilder(List<Company> comp) {
    return ListView.builder(
      itemCount: comp.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: Text(
              comp[index].companyName,
              softWrap: true,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            key: UniqueKey(),
            subtitle: Text('Job Profile : ' + comp[index].jobProfile),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompanyPage(company: comp[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CompanyPage extends StatelessWidget {
  Company company;
  RestDataSource rest = RestDataSource();
  String url = RestURl.baselURL + RestURl.applyURL;

  CompanyPage({Key key, this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Company Details'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                    child: Text('Company Name',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.companyName,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Job Profile',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.jobProfile,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Job Package',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.jobPackage,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Eligibility Criteria',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.eligibilityCriteria,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Vacancies',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.noOfVacancies.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Job Description',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.jobDescription,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Batch Year',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.batchYear.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Last Apply Date',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.lastDateApply,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('Backlog Allow',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.backlog_Allow.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    child: Text('No. Of Backlogs Allow',
                        style: TextStyle(fontSize: 15, color: Colors.orange))),
                SizedBox(height: 10),
                Text(
                  this.company.noOfBacklog.toString(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                new Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      onPressed: () {
                        int compId = this.company.companyId;
                        var json = {
                          'companyId': compId.toString(),
                          'studentId': username,
                        };
                        var uri = Uri.http(RestURl.basURL,
                            '/ymca/api/company/addStudent', json);
                        print(jsonEncode(json));
                        rest.post(uri.toString()).then((dynamic res) {
                          if(res['message'] == 'Success')
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully Applied'),));
                          else if(res['message'].toString().contains('update'))
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message']),));
                            
                        });
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
                            'Apply',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
