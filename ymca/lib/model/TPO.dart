class TrainingPlacementOfficer{
   int tpoId;
   String name;
   String phoneNo;
   String tpoEmail;
   String branch;

   TrainingPlacementOfficer();

   TrainingPlacementOfficer.fromJson(Map<String,dynamic> json){
     this.tpoId = json['tpoId'];
     this.name = json['name'];
     this.phoneNo = json['phoneNo'];
     this.tpoEmail = json['tpoEmail'];
     this.branch = json['branch'];

   }
   Map<String, dynamic> toJson() {
     return {
       'name': name,
       'phoneNo': phoneNo,
       'tpoEmail': tpoEmail,
       'branch': branch,
     };
   }
}