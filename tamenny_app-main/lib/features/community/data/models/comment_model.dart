import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';

class CommentModel {
  final String username;
  final String comment;
  final String? avatarUrl;

  CommentModel({
    required this.username,
    required this.comment,
    this.avatarUrl,
  });

  // Optional: Add factory methods for JSON serialization/deserialization if needed

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      username: json['username'],
      comment: json['comment'],
      avatarUrl: json['avatarUrl'],
    );
  }

  factory CommentModel.fromEntity(CommentEntity entity) {
    return CommentModel(
      username: entity.username,
      comment: entity.comment,
      avatarUrl: entity.avatarUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'comment': comment,
      'avatarUrl': avatarUrl,
    };
  }

  CommentEntity toEntity() {
    return CommentEntity(
      username: username,
      comment: comment,
      avatarUrl: avatarUrl,
    );
  }
}
