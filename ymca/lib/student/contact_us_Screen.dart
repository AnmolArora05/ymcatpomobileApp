
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ymca/student/home_Screen_student.dart';

class ContactUs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Contact Us")
      ),
      body: Container(

        child: Column(

          children: <Widget>[
            SizedBox(height: 50),
            Container(


                alignment: Alignment.center,
                child:Image.asset(
                'assets/images/ymca.png',
                height: 120,
              ),
              ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Text('   On behalf of J.C. Bose University of Science and Technology, YMCA, Faridabad, it is my pleasure to invite you to our academic campus to give training and conduct campus selections for our dynamic students. The J.C.Bose University of Science and Technology Faridabad is one of the premier institutions established by the coalition of State Government of Haryana and German Government in 1969 as a diploma institute,converted to degree college in 1997. ',style: TextStyle(
                fontSize: 15,
                color: Colors.black,

              ),

              ),
            ),
            SizedBox(height: 20),
            Container(

              alignment: Alignment.centerLeft,
              child: Text('   Phone            +91-129-2242141 ',style: TextStyle(
                  fontSize: 20,
                color: Colors.black,

              ),

              ),
            ),
            SizedBox(height: 20),
            new Container(
              alignment: Alignment.centerLeft,
              child: Text('   Email              tpo@jcboseust.ac.in',style: TextStyle(
                fontSize: 20,
                color: Colors.black,

              ),

              ),
            ),

          ],
        ),
      ),


    );
  }



}