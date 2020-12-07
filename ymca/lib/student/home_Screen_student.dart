
import 'package:flutter/material.dart';
import 'package:ymca/student/certification_screen.dart';
import 'package:ymca/student/educational_details_screen.dart';
import 'package:ymca/student/opportunities_screen.dart';
import 'package:ymca/student/personal_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ymca/auth/login_screen.dart';
import 'package:ymca/student/change_password_screen.dart';
import 'package:ymca/student/contact_us_Screen.dart';

class HomeStudent extends StatefulWidget {
  String role;
  String token;
  String username;

  HomeStudent(String token, String role, String username) {
    this.token = token;
    this.role = role;
    this.username = username;
  }

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeStudent> {
  int _currentIndex = 0;

  void initState() {
    super.initState();
    future();
  }

  Future future() async {
    print("*******************************" + this.widget.role);
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("role", this.widget.role);
    sp.setString("token", this.widget.token);
    sp.setString("username", this.widget.username);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text("Welcome " + this.widget.username,style: TextStyle(
          fontSize:  40,
        ),),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  Route personal;
  Route educational;
  Route certifications;
  Route opportunities;
  Route contactUs;
  Route changePassword;
  String username;
  Route login;

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
    sp.remove("email");
    return null;
  }

  @override
  Widget build(BuildContext context) {
    getUserName();
    personal = MaterialPageRoute(builder: (context) => PersonalDetails.name());
    educational = MaterialPageRoute(builder: (context) => EducationalDetails());
    certifications = MaterialPageRoute(builder: (context) => Certifications());
    opportunities = MaterialPageRoute(builder: (context) => Opportunities());
    login = MaterialPageRoute(builder: (context) => LoginScreen());
    contactUs = MaterialPageRoute(builder: (context) => ContactUs());
    changePassword = MaterialPageRoute(builder: (context) => ChangePasswordStudent());
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
              title: Text('Education Details'),
              onTap: () => {Navigator.of(context).pushReplacement(educational)}),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('Certifications'),
            onTap: () => {Navigator.of(context).pushReplacement(certifications)},
          ),
          ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('Opportunities'),
            onTap: () => {Navigator.of(context).pushReplacement(opportunities)},
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Change Password'),
            onTap: () => {Navigator.of(context).pushReplacement(changePassword)},
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            onTap: () => {Navigator.of(context).pushReplacement(contactUs)},
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
