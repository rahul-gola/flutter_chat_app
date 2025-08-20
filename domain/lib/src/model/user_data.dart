class UserDataModel {
  UserDataModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.createdAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      uid: json['uid'] as String,
      email: json['email'] as String? ?? '',
      displayName: json['name'] as String? ?? '',
      createdAt: json['createdAt'],
    );
  }

  final String uid;
  final String email;
  final String displayName;
  final dynamic createdAt;
}
