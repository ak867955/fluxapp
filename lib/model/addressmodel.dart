class Addressmodel {
  String housename;
  String city;
  String districts;
  int pincode;

  Addressmodel({
    required this.housename,
    required this.city,
    required this.districts,
    required this.pincode,
  });

  Map<String, dynamic> data(docId) => { 
        "House Name": housename,
        "City": city,
        "Distict": districts,
        "Pin Code": pincode
      };
  factory Addressmodel.fromData(Map<String, dynamic> i) {
    return Addressmodel(
        housename: i["House Name"],
        city: i["City"],
        districts: i["Distict"],
        pincode: i["Pin Code"]);
  }
}
