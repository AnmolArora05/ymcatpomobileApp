

class User {
  String username;
  String password;
  String name;
  String department;
  String phoneNumber;
  String email;

  User();

  User.fromJson(Map<String,dynamic> json){
    this.username = json['username'];
    this.name = json['name'];
    this.department = json['department'];
    this.email = json['email'];
    this.phoneNumber = json['phoneNumber'];
    this.password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'department': department,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}