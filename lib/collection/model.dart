class UserModel {
  String firstname;
  String email;
  String secondname;
  String? id;
  String? profilePictureUrl; 

  UserModel(
      {required this.firstname,
      required this.email,
      required this.secondname,
      required this.id,
      this.profilePictureUrl});

  Map<String, dynamic> data(docId) => {
        "name": firstname,
        "email": email,
        "phone": secondname,
        "id": docId,
        "profilePictureUrl": profilePictureUrl,
      };

  factory UserModel.fromData(Map<String, dynamic> i) {
    return UserModel(
        firstname: i["name"],
        email: i["email"],
        secondname: i["phone"],
        id: i["id"],
        profilePictureUrl: i["profilePictureUrl"]);
  }
}
