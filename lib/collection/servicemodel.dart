import 'package:cloud_firestore/cloud_firestore.dart'; // Ensure you have the necessary import for Timestamp

class Servicemodel {
  String title;
  String description;
  double price;
  int duration;
  String category;
  String? serviceId;
  Timestamp? timestamp;
  String? uid;
  String? imageUrl;

  Servicemodel({
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.category,
    this.serviceId,
    this.timestamp,
    this.uid,
    this.imageUrl,
  });

  Map<String, dynamic> data(docId) => {
        "Title": title,
        "Description": description,
        "Price": price,
        "Duration": duration,
        "Category": category,
        "WorkId": serviceId,
        "Timestamp": timestamp,
        "Uid": uid,
        "ImageUrl": imageUrl,
      };

  factory Servicemodel.fromData(Map<String, dynamic> i) {
    return Servicemodel(
      title: i["Title"],
      description: i["Description"],
      price: i["Price"],
      duration: i["Duration"],
      category: i["Category"],
      serviceId: i["WorkId"],
      timestamp: i["Timestamp"],
      uid: i["Uid"],
      imageUrl: i["ImageUrl"],
    );
  }
}
