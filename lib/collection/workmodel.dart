class Workmodel {
  String jobname;
  String companyname;
  String jobdescription;
  String reference;

  Workmodel({
    required this.jobname,
    required this.companyname,
    required this.jobdescription,
    required this.reference,
  });

  Map<String, dynamic> data(docId) => {
        "Job Name": jobname,
        "Company Name": companyname,
        "Job Description": jobdescription,
        "Referenses": reference,
      };
  factory Workmodel.fromData(Map<String, dynamic> i) {
    return Workmodel(
      jobname: i["Job Name"],
      companyname: i["Company Name"],
      jobdescription: i["Job Description"],
      reference: i["Referenses"],
      ); 
  }
}
