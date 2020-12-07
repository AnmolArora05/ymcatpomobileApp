
class StudentEducationDetails{
  int id;
  String hsscStream;
  String gradCourse;
  String pgCourse;
  String gapReason;
  int sscPassYear;
  int hsscPasYear;
  int gradPassYear;
  int pgPassYear;
  double sscMarks;
  double hsscMarks;
  double gradsCgpa;
  double pgCgpa;
  int gapYear;

  StudentEducationDetails();


  StudentEducationDetails.fromJson(Map<String,dynamic> json){
    this.id = json['id'];
    this.hsscStream = json['hsscStream'];
    this.gradCourse = json['gradCourse'];
    this.pgCourse = json['pgCourse'];
    this.gapReason = json['gapReason'];
    this.sscPassYear = json['sscPassYear'];
    this.hsscPasYear = json['hsscPasYear'];
    this.gradPassYear = json['gradPassYear'];
    this.pgPassYear = json['pgPassYear'];
    this.sscMarks = json['sscMarks'];
    this.hsscMarks = json['hsscMarks'];
    this.gradsCgpa = json['gradsCgpa'];
    this.pgCgpa = json['pgCgpa'];
    this.gapYear = json['gapYear'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'hsscStream': hsscStream,
      'gradCourse': gradCourse,
      'pgCourse': pgCourse,
      'gapReason': gapReason,
      'sscPassYear': sscPassYear,
      'hsscPasYear': hsscPasYear,
      'gradPassYear': gradPassYear,
      'pgPassYear': pgPassYear,
      'sscMarks': sscMarks,
      'hsscMarks': hsscMarks,
      'gradsCgpa': gradsCgpa,
      'pgCgpa': pgCgpa,
      'gapYear' : gapYear,
    };
  }


}