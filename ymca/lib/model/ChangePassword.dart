
class ChangePasswordModel{
    String username;
    String newPassword;
    String prevPassword;


    ChangePasswordModel();
    ChangePasswordModel.fromJson(Map<String,dynamic> json){
      this.username = json['username'];
      this.newPassword = json['newPassword'];
      this.prevPassword = json['prevPassword'];
    }



    Map<String, dynamic> toJson() {
      return {
        'prevPassword': prevPassword,
        'newPassword': newPassword,
        'username': username,
      };
    }


}