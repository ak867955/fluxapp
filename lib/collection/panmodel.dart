class Panmodel {
  int pannumber;

  Panmodel({
    required this.pannumber,
  });

  Map<String, dynamic> data(docId) => {
        "Pan Card Number": pannumber,
      };
  factory Panmodel.fromData(Map<String, dynamic> i) {
    return Panmodel(pannumber: i["Pan Card Number"]); 
  }
}
