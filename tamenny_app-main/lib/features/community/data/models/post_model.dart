import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tamenny_app/features/community/data/models/comment_model.dart';
import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';

class PostModel {
  final String postId;
  final String postText;
  final String username;
  final String userAvatarUrl;
  final int commentsCount;
  final int likesCount;
  final int sharesCount;
  final Timestamp createdAt;
  final List<String> likedBy;
  String? imageUrl;
  final List<CommentEntity>? comments;
  final String tag;

  PostModel({
    required this.postId,
    required this.postText,
    required this.username,
    required this.userAvatarUrl,
    required this.commentsCount,
    required this.likesCount,
    required this.sharesCount,
    required this.createdAt,
    required this.imageUrl,
    required this.tag,
    this.comments,
    this.likedBy = const [],
  });

  factory PostModel.fromJson(Map<String, dynamic> data) {
    return PostModel(
      postId: data['postId'] ?? '',
      postText: data['postText'] ?? '',
      username: data['username'] ?? '',
      userAvatarUrl: data['userAvatarUrl'] ?? '',
      commentsCount: data['commentsCount'] ?? 0,
      likesCount: data['likesCount'] ?? 0,
      sharesCount: data['sharesCount'] ?? 0,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      likedBy: List<String>.from(data['likedBy'] ?? []),
      imageUrl: data['imageUrl'] ?? '',
      comments: (data['comments'] as List<dynamic>?)
              ?.map((comment) => CommentModel.fromJson(comment).toEntity())
              .toList() ??
          [],
      tag:data["tag"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
       'postText': postText,
      'username': username,
      'userAvatarUrl': userAvatarUrl,
      'commentsCount': commentsCount,
      'likesCount': likesCount,
      'sharesCount': sharesCount,
      'createdAt': createdAt,
      'likedBy': likedBy,
      'imageUrl': imageUrl,
      'comments': comments,
      'tag':tag
    };
  }

  PostEntity toEntity() {
    return PostEntity(
        postId: postId,
        postText: postText,
        username: username,
        userAvatarUrl: userAvatarUrl,
        commentsCount: commentsCount,
        likesCount: likesCount,
        sharesCount: sharesCount,
        createdAt: createdAt,
        imageUrl: imageUrl,
        comments: comments,
        likedBy: likedBy,
        tag:tag
    );}

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
        postId: entity.postId,
        postText: entity.postText,
        username: entity.username,
        userAvatarUrl: entity.userAvatarUrl,
        commentsCount: entity.commentsCount ?? 0,
        likesCount: entity.likesCount ?? 0,
        sharesCount: entity.sharesCount ?? 0,
        createdAt: entity.createdAt,
        likedBy: [],
        imageUrl: entity.imageUrl,
        comments: entity.comments,
        tag:entity.tag);
  }
}


