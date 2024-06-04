class ChannelModel {
  String? channelId;
  String ownerId;
  String name;
  String description;
  String type;
  String payment; // Optional payment field
  String profile;
  List<dynamic> members = [];
  String category;

  ChannelModel({
     this.channelId,
     required this.category,
    required this.ownerId,
    required this.profile,
    required this.members,
    required this.name,
    required this.description,
    required this.type,
    required this.payment,
  });

  Map<String, dynamic> data(docId) => {
        "Name": name,
        "Description": description,
        "Type": type,
        "Payment": payment,
        "channelId": docId,
        "OwnerId": ownerId,
        "Members": members.map((e) => e).toList(),
        "Profile": profile,
        "category":category
      };

  factory ChannelModel.fromData(Map<String, dynamic> i) {
    return ChannelModel(
        name: i["Name"],
        category:i["category"],
        description: i["Description"],
        type: i["Type"],
        payment: i["Payment"],
        channelId: i["channelId"],
        ownerId: i["OwnerId"],
        members: i["Members"],
        profile: i["Profile"]);
  }
}
