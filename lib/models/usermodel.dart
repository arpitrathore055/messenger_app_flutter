class UserModel {
  String userId;
  String userDisplayName;
  String userEmail;
  String userPhotoUrl;
  String status;

  UserModel({
    required this.status,
    required this.userId,
    required this.userDisplayName,
    required this.userEmail,
    required this.userPhotoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userEmail: json["userId"],
        userDisplayName: json["userDisplayName"],
        userId: json["userId"],
        userPhotoUrl: json["userPhotoUrl"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userDisplayName": userDisplayName,
        "userEmail": userEmail,
        "userPhotoUrl": userPhotoUrl,
        "status": status
      };
}
