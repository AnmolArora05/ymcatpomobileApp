
class Certificate{
  String certiTitle;
  String orgiDetails;
  String issueDate;
  int certificateId;

  Certificate();
  Certificate.fromJson(Map<String,dynamic> json){
    this.certiTitle = json['certiTitle'];
    this.orgiDetails = json['orgiDetails'];
    this.issueDate = json['issueDate'];
    this.certificateId = json['certificateId'];
  }



  Map<String, dynamic> toJson() {
    return {
      'certiTitle': certiTitle,
      'orgiDetails': orgiDetails,
      'issueDate': issueDate,
      'certificateId' : certificateId,
    };
  }


}