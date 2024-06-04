class Addressmodel {
  String housename;
  String city;
  String state;
  int pincode;

  Addressmodel({
    required this.housename,
    required this.city,
    required this.state,
    required this.pincode,
  });

  Map<String, dynamic> data(docId) => {
        "House Name": housename,
        "City": city,
        "State": state,
        "Pin Code": pincode
      };
  factory Addressmodel.fromData(Map<String, dynamic> i) {
    return Addressmodel(
        housename: i["House Name"],
        city: i["City"],
        state: i["State"],
        pincode: i["Pin Code"]);
  }
}
