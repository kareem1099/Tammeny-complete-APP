import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';

import '../../../../core/services/database_service.dart';

abstract class RecommendationRepo {
  Future<Either<Failure, List<PostEntity>>> getPostsByModelScores(
      List<int> scores,
      DatabaseService databaseService, {
        required Map<String, Set<String>> shownPostIdsPerCategory,
        required Map<String, int> skippedCountsPerCategory,
      });

  Future<Either<Failure, void>> addPost({required PostEntity post});

  Future<Either<Failure, void>> addComment(
      {required CommentEntity comment, required PostEntity post});

  Future<Either<Failure, void>> addLike({
    required PostEntity post,
    required String userId,
  });

  buildModelInput(
  List<double> userRatios,
  Map<String, Set<String>> shownPostIdsPerCategory,);

  Future<Either<Failure, Map<String, double>>> getDiseaseScores();
}