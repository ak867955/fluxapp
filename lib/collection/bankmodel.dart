class Bankmodel {
  String accountname;
  int accnumber;
  int ifsccode;

  Bankmodel({
    required this.accountname,
    required this.accnumber,
    required this.ifsccode,
  });

  Map<String, dynamic> data(docId) => {
        "Account Holder Name": accountname,
        "Account Holder Number": accnumber,
        "IFSC Code": ifsccode,
      };
  factory Bankmodel.fromData(Map<String, dynamic> i) {
    return Bankmodel(
        accountname: i["Account Holder Name"],
        accnumber: i["Account Holder Number"],
        ifsccode: i["IFSC Code"]);
  }
}
