class CommentEntity {
  final String username;
  final String comment;
  final String? avatarUrl;

  CommentEntity({
    required this.username,
    required this.comment,
    this.avatarUrl,
  });

  // factory Comment.fromJson(Map<String, dynamic> json) {
  //   return Comment(
  //     username: json['username'],
  //     comment: json['comment'],
  //     avatarUrl: json['avatarUrl'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'username': username,
  //     'comment': comment,
  //     'avatarUrl': avatarUrl,
  //   };
  // }
}
