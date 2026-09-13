class CommentsModel {
  int postId;
  int id;
  String name;
  String email;
  String body;

  CommentsModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
      postId: json["postId"],
      id: json["id"],
      name: json["name"],
      email: json["email"],
      body: json["body"],
    );
  }
}
