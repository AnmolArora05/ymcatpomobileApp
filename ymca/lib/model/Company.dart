
class Company{
   int companyId;
   String companyName;
   String jobProfile;
   String jobPackage;
   String jobDescription;
   int noOfVacancies;
   String eligibilityCriteria;
   bool backlog_Allow;
   int noOfBacklog;
   int batchYear;
   String lastDateApply;

   Company();

   Company.fromJson(Map<String,dynamic> json){

     this.companyId = json['companyId'];
     this.companyName = json['companyName'];
     this.jobProfile = json['jobProfile'];
     this.jobPackage = json['jobPackage'];
     this.jobDescription = json['jobDescription'];
     this.noOfVacancies = json['noOfVacancies'];
     this.eligibilityCriteria = json['eligibilityCriteria'];
     this.backlog_Allow = json['backlog_Allow'];
     this.noOfBacklog = json['noOfBacklog'];
     this.batchYear = json['batchYear'];
     this.lastDateApply = json['lastDateApply'];
   }

   Map<String, dynamic> toJson() {
     return {
       'companyName': companyName,
       'jobProfile': jobProfile,
       'jobPackage': jobPackage,
       'jobDescription': jobDescription,
       'noOfVacancies': noOfVacancies,
       'eligibilityCriteria': eligibilityCriteria,
       'backlog_Allow' : backlog_Allow,
       'noOfBacklog' : noOfBacklog,
       'batchYear' : batchYear,
       'lastDateApply' : lastDateApply,
     };
   }
}