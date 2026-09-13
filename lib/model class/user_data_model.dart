class UserPostDataModel {
  int userId;
  int id;
  String title;
  String body;

  UserPostDataModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory UserPostDataModel.fromJson(Map<String, dynamic> json) {
    return UserPostDataModel(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}
