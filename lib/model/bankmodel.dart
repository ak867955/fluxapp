class Bankmodel {
  String accountname;
  String upiid;
  // int ifsccode;

  Bankmodel({
    required this.accountname,
    required this.upiid,
    // required this.ifsccode,
  });

  Map<String, dynamic> data(docId) => {
        "Account Holder Name": accountname,
        "UPI iD": upiid,
        // "IFSC Code": ifsccode,
      };
  factory Bankmodel.fromData(Map<String, dynamic> i) {
    return Bankmodel(accountname: i["Account Holder Name"], upiid: i["UPI iD"]
        // ifsccode: i["IFSC Code"]
        );
  }
}
