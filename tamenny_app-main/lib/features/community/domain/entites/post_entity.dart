import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';

class PostEntity {
  final String postId;
  final String userAvatarUrl;
  final String username;
  final Timestamp createdAt;
  final String postText;
  String? imageUrl;
  final int commentsCount;
  final int likesCount;
  final int sharesCount;
  List<CommentEntity>? comments;
  final List<String> likedBy;
  final String tag;

  PostEntity({
    required this.postId,
    required this.userAvatarUrl,
    required this.username,
    required this.createdAt,
    required this.postText,
    required this.commentsCount,
    required this.likesCount,
    required this.tag,
    required this.sharesCount,
    required this.likedBy,
    this.comments,
    this.imageUrl,
  });

  PostEntity copyWith({
    String? postId,
    String? userAvatarUrl,
    String? username,
    Timestamp? createdAt,
    String? postText,
    String? imageUrl,
    int? commentsCount,
    int? likesCount,
    int? sharesCount,
    String?tag ,
    List<CommentEntity>? comments,
    List<String>? likedBy,
  }) {
    return PostEntity(
      postId: postId ?? this.postId,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      postText: postText ?? this.postText,
      imageUrl: imageUrl ?? this.imageUrl,
      commentsCount: commentsCount ?? this.commentsCount,
      likesCount: likesCount ?? this.likesCount,
      sharesCount: sharesCount ?? this.sharesCount,
      comments: comments ?? this.comments,
      likedBy: likedBy ?? this.likedBy,
        tag: tag ??this.tag,
    );
  }
}
