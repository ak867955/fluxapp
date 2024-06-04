class Servicemodel {
  String title;
  String description;
  double price;
  int duration;


  Servicemodel({
    required this.title,
    required this.description,
    required this.price,
    required this.duration,

  });

  Map<String, dynamic> data(docId) => {
        "Title": title,
        "Description": description,
        "Price": price,
        "Duration": duration,

      };
  factory Servicemodel.fromData(Map<String, dynamic> i) {
    return Servicemodel(
      title: i["Title"],
      description: i["Description"],
      price: i["Price"],
      duration: i["Duration"],

    );
  }
}
