class Panmodel {
  String pannumber;
  String imageurl; 

  Panmodel({
    required this.pannumber, 
    required this.imageurl,
  });

  Map<String, dynamic> data(docId) => {
        "Pan Card Number": pannumber,
        "Image":imageurl,
      };
  factory Panmodel.fromData(Map<String, dynamic> i) {
    return Panmodel(pannumber: i["Pan Card Number"],
    imageurl: i["Image"]);  
  }
}
