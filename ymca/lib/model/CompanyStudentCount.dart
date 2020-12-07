import 'package:ymca/model/Company.dart';

class CompanyStudentCount {

  Company company;
  int countStudent;
  CompanyStudentCount();

  CompanyStudentCount.fromJson(Map<String, dynamic> json){
    this.company = Company.fromJson(json['company'] as Map<String , dynamic>);
    print(this.company.companyName);
    this.countStudent = json['countStudent'];
  }
}
