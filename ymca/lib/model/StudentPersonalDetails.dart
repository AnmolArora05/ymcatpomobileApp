
class StudentPersonalDetails{
   String rollNo;
   String fullName;
   String fatherName;
   String motherName;
   String dob;
   String gender;
   String email;
   String contactNo;
   String address;
   int zipCode;
   String state;
   String city;

   StudentPersonalDetails({this.rollNo,this.fullName,this.fatherName,this.motherName,this.contactNo,this.dob,this.gender,this.address,this.email,this.city,this.state,this.zipCode});

   StudentPersonalDetails.fromJson(Map<String,dynamic> json){
       this.rollNo = json['rollNo'];
       this.fullName = json['fullName'];
       this.fatherName = json['fatherName'];
       this.motherName = json['motherName'];
       this.contactNo = json['contactNo'];
       this.dob = json['dob'];
       this.gender = json['gender'];
       this.email = json['email'];
       this.address = json['address'];
       this.zipCode = json['zipCode'];
       this.state = json['state'];
       this.city = json['city'];
}

  Map<String, dynamic> toJson() {
    return {
      'rollNo': rollNo,
      'fullName': fullName,
      'fatherName': fatherName,
      'motherName': motherName,
      'contactNo': contactNo,
      'dob': dob,
      'gender': gender,
      'email': email,
      'address': address,
      'zipCode': zipCode,
      'state': state,
      'city': city,
    };
  }


}