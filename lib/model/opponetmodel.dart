// opponent_profile_model.dart
class OpponentProfileModel {
  final String uid;
  final String name;
  final String photoUrl;

  OpponentProfileModel({
    required this.uid,
    required this.name,
    required this.photoUrl,
  });

  factory OpponentProfileModel.fromData(Map<String, dynamic> data) {
    return OpponentProfileModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }
}
