import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/certification_screen.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/educational_details_screen.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/opportunities_screen.dart';
import 'file:///C:/Users/shubh/AndroidStudioProjects/ymca/lib/student/personal_details_screen.dart';
import 'package:ymca/admin/add_company.dart';
import 'package:ymca/admin/add_tpo.dart';
import 'package:ymca/admin/show_company.dart';
import 'package:ymca/admin/show_tpo-details.dart';
import 'package:ymca/auth/login_screen.dart';

class HomeAdmin extends StatefulWidget {
  String role;
  String token;
  String username;

  HomeAdmin(String token, String role, String username) {
    this.token = token;
    this.role = role;
    this.username = username;
  }

  @override
  State<StatefulWidget> createState() {
    return HomeAdminState();
  }
}

class HomeAdminState extends State<HomeAdmin> {
  int _currentIndex = 0;

  Future future() async {
    print("*******************************" + this.widget.role);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("role", this.widget.role);
    sp.setString("token", this.widget.token);
    sp.setString("username", this.widget.username);

    return null;
  }

  void initState() {
    super.initState();
    future();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text("Welcome Admin",style: TextStyle(
          fontSize:  40,
        ),),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  Route personal;
  Route addCompany;
  Route addTPO;
  Route opportunities;
  Route login;
  Route companies;
  String username;

  Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    username = sp.getString("username");
    return username;
  }

  Future logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("username");
    sp.remove("role");
    sp.remove("token");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    personal = MaterialPageRoute(builder: (context) => TpoDetails.name());
    addCompany = MaterialPageRoute(builder: (context) => AddCompany());
    addTPO = MaterialPageRoute(builder: (context) => AddOfficer());
    opportunities = MaterialPageRoute(builder: (context) => Opportunities());
    companies = MaterialPageRoute(builder: (context) => ShowCompaniesList());
    login = MaterialPageRoute(builder: (context) => LoginScreen());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Image.asset(
                        'assets/images/pro.png',
                        height: 120,
                      ),
                      SizedBox(height: 10),
                      Center(
                          child: FutureBuilder<String>(
                        future: getUserName(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData)
                            return Text(snapshot.data);
                          else
                            return Container();
                        },
                      )),
                    ],
                  ))),
          ListTile(
            leading: Icon(Icons.details),
            title: Text('Personal Details'),
            onTap: () => {Navigator.of(context).pushReplacement(personal)},
          ),
          ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Add a New Company'),
              onTap: () => {Navigator.of(context).pushReplacement(addCompany)}),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Companies'),
            onTap: () => {Navigator.of(context).pushReplacement(companies)},
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add a New TPO'),
            onTap: () => {Navigator.of(context).pushReplacement(addTPO)},
          ),
          ListTile(
            leading: Icon(Icons.local_cafe),
            title: Text('LogOut'),
            onTap: ()  {
              logout();
              Navigator.of(context).pushReplacement(login);
            }
          ),
        ],
      ),
    );
  }
}
