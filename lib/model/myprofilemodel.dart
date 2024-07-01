class Myprofilemodel {
  String firstname;
  String secondname;
  String aboutme;
  String skill;
  String qualification;
  String experience;
  int age;
  String gender;
  String? id;
  String email;
  String url;
  int rating;
  String? since;
  String phoneNumber;

  Myprofilemodel({
    required this.firstname, 
    required this.secondname, 
    required this.aboutme,
    required this.skill,
    required this.qualification, 
    required this.experience,
    required this.age,
    required this.gender,
    this.id,
    required this.email,
    required this.url,
    required this.rating,
    this.since,
    required this.phoneNumber,
  });

  Map<String, dynamic> data(docId) => {
        "First Name": firstname,
        "Second Name": secondname,
        "Id": docId,
        "Email": email,
        "image": url,
        "aboutme": aboutme,
        "skill": skill,
        "qualification": qualification,
        "experience": experience, 
        "age": age,
        "gender": gender,
        "Rating": rating,
        'since': since,
        'phoneNumber': phoneNumber,
      };

  factory Myprofilemodel.fromData(Map<String, dynamic> i) {
    return Myprofilemodel(
        firstname: i["First Name"],
        secondname: i["Second Name"],
        aboutme: i["aboutme"],
        skill: i["skill"],
        qualification: i["qualification"],
        experience: i["experience"],
        age: i["age"],
        gender: i["gender"],
        id: i["Id"],
        email: i["Email"],
        url: i["image"],
        rating: i["Rating"],
        since: i['since'],
        phoneNumber: i['phoneNumber'],
    );
  }
}
