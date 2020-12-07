import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/admin/home_screen_admin.dart';
import 'package:ymca/data/rest_api.dart';
import 'package:ymca/data/rest_url.dart';
import 'package:http/http.dart' as http;
import 'package:ymca/model/CompanyStudentCount.dart';

class ShowCompaniesList extends StatefulWidget {
  @override
  CompaniesListState createState() {
    return CompaniesListState();
  }
}
String username;

Future<List<CompanyStudentCount>> get(String url) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  username = pref.getString("username");
  final response = await http.get(url, headers: {"Content-Type": "application/json"});
  return compute(parsePhotos, response.body);
}

List<CompanyStudentCount> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<CompanyStudentCount> list = parsed.map<CompanyStudentCount>((json) => CompanyStudentCount.fromJson(json)).toList();
  print(list.length.toString()+"************************************");
  return list;
}

class CompaniesListState extends State<ShowCompaniesList> {
  String url = RestURl.baselURL + RestURl.getCompanyStudentCountListURl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Companies'),
      ),
      drawer: NavDrawer(),
      body:Container(
      child: FutureBuilder<List<CompanyStudentCount>>(
        future: get(url),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Container(
                child: Center(
              child: Text('No Data'),
            ));
          else if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasData && snapshot.data.length != 0)
            return listBuilder(snapshot.data);
          else
            return Container(
                child: Center(
              child: Text('No Data'),
            ));
        },
      ),
    ));
  }

  Widget listBuilder(List<CompanyStudentCount> comp) {
    return ListView.builder(
      itemCount: comp.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            title: Text(
              comp[index].company.companyName,
              softWrap: true,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            key: UniqueKey(),
            subtitle: Text('Job Profile : ' + comp[index].company.jobProfile),
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
  CompanyStudentCount company;
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

                child: Text('Company Name',style: TextStyle(
                      fontSize: 15,
                color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.companyName,style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Total Students Applied',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.countStudent.toString(),style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Job Profile',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.jobProfile,style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Job Package',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.jobPackage,style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),

            Container(

                child: Text('Eligibility Criteria',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.eligibilityCriteria,style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Vacancies',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.noOfVacancies.toString(),style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Job Description',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.jobDescription,style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Batch Year',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.batchYear.toString(),style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Last Apply Date',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.lastDateApply,style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('Backlog Allow',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.backlog_Allow.toString(),style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.symmetric(horizontal:1.0),
              child:Container(
                height:1.0,

                color:Colors.grey,),),
            SizedBox(height: 20),
            Container(

                child: Text('No. Of Backlogs Allow',style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange)
                )),
            SizedBox(height: 10),
            Text(this.company.company.noOfBacklog.toString(),style: TextStyle(
              fontSize: 15,
            ),),
            new Container(
                margin: EdgeInsets.only(top: 25.0,left: 100),
                child: RaisedButton(
                  onPressed: () {
                    int compId = this.company.company.companyId;
                    var param = {
                      'tpoId': username,

                    };
                    print(this.company.company.companyId.toString() + "");
                    var uri = Uri.http(RestURl.basURL,'/ymca/api/company/download/'+this.company.company.companyId.toString(),param);
                    rest.get(uri.toString()).then((dynamic res) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Successfully Exported')));
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
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: 110.0, minHeight: 40.0),
                      // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'Export To Excel',
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

