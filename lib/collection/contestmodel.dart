class Contestmodel {
  String title;
  String description;
  double budget;
  String skill;
  String deadline;

  Contestmodel({
    required this.title,
    required this.description,
    required this.budget,
    required this.skill,
    required this.deadline,
  });

  Map<String, dynamic> data(docId) => {
        "Title": title,
        "Description": description,
        "Budget": budget,
        "Skill": skill,
        "Deadline": deadline,
      };
  factory Contestmodel.fromData(Map<String, dynamic> i) {
    return Contestmodel(
      title: i["Title"],
      description: i["Description"],
      budget: i["Budget"],
      skill: i["Skill"],
      deadline: i["Deadline"],
    );
  }
}
