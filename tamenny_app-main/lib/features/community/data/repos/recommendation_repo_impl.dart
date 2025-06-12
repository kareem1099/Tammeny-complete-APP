import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/recommendation_sys/recomm_model.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/local_count_service.dart';
import 'package:tamenny_app/core/utils/backend_end_point.dart';
import 'package:tamenny_app/features/community/data/models/comment_model.dart';
import 'package:tamenny_app/features/community/data/models/post_model.dart';
import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import 'dart:developer' as developer;

import '../../../../core/cubits/user_cubit/user_cubit.dart';
import '../../../../core/services/get_it_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
class RecommendationRepoImpl implements RecommendationRepo {
  final DatabaseService databaseService;
  final DiseasePriorityModel model;
  final LocalCounterService localCounterService;
  RecommendationRepoImpl(this.databaseService, this.model,this.localCounterService);@override
  Future<Either<Failure, List<double>>> buildModelInput(
      List<double> userRatios,
      Map<String, Set<String>> shownPostIdsPerCategory,
      ) async {
    developer.log('buildModelInput started with userRatios: $userRatios');
    try {
      if (userRatios.length != 5) {
        final msg = "Expected exactly 5 user ratios";
        developer.log(msg, level: 1000);
        return left(ServerFailure(errMessage: msg));
      }

      final collections = ['heart', 'brain', 'lung', 'knee', 'neutral'];
      List<double> availableCounts = [];

      for (String collection in collections) {
        final totalCountSnapshot = await FirebaseFirestore.instance.collection(collection).count().get();
        final totalCount = totalCountSnapshot.count ?? 0;

        final shownCount = shownPostIdsPerCategory[collection]?.length ?? 0;

        final availableCount = ((totalCount - shownCount).toDouble().clamp(0, totalCount.toDouble())) as double;
        developer.log('Available count for $collection: $availableCount (Total: $totalCount, Shown: $shownCount)');

        availableCounts.add(availableCount);
      }

      final rawInput = [...userRatios, ...availableCounts];
      developer.log('Raw input before scaling: $rawInput');

      final means = [
        0.19806539375936677,
        0.1973385956580475,
        0.20249491750580473,
        0.19846125503614778,
        0.19774274041556728,
        146.60131926121372,
        146.00369393139843,
        147.91160949868075,
        148.21767810026384,
        148.46437994722956,
      ];

      final stds = [
        0.16301181924117641,
        0.16173318835074527,
        0.16504179705184804,
        0.16107439345267072,
        0.16245651100693032,
        87.64716473672266,
        87.74249315518895,
        87.96217913153258,
        88.26317898196235,
        92.51515841180395,
      ];

      List<double> scaledInput = List.generate(
        rawInput.length,
            (i) => (rawInput[i] - means[i]) / stds[i],
      );

      developer.log('Scaled input: $scaledInput');
      return right(scaledInput);
    } catch (e) {
      developer.log('buildModelInput failed with error: $e', level: 1000);
      return left(ServerFailure(errMessage: e.toString()));
    }
  }Future<void> incrementPostCount(String tag) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'posts_${tag}';
    final currentCount = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, currentCount + 1);
  }

  Future<int> getPostCount(String tag) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'posts_${tag}';
    return prefs.getInt(key) ?? 0;
  }
  Future<int> getScanCount(String tag) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'scan_${tag}';
    return prefs.getInt(key) ?? 0;
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPostsByModelScores(
      List<int> scores,
      DatabaseService databaseService, {
        required Map<String, Set<String>> shownPostIdsPerCategory,
        required Map<String, int> skippedCountsPerCategory,
      }) async {
    developer.log('getPostsByModelScores started with scores: $scores');
    try {
      final collections = ['heart', 'brain', 'lung', 'knee', 'neutral'];
      List<PostEntity> allPosts = [];

      for (int i = 0; i < collections.length; i++) {
        final category = collections[i];
        final limit = scores[i];

        developer.log('Category: $category, limit: $limit');

        if (limit == 0) {
          developer.log('Skipping category $category due to zero score limit');
          continue;
        }

        final shownIds = shownPostIdsPerCategory[category] ?? {};
        final skipCount = skippedCountsPerCategory[category] ?? 0;  // ضبط skipCount هنا

        final snapshot = await databaseService.getData(
          path: category,
          query: {
            'orderBy': 'createdAt',
            'descending': true,
            'limit': limit + skipCount,
          },
        );

        developer.log('Received snapshot for $category with ${snapshot.length} items');

        if (snapshot is List) {
          final posts = snapshot
              .map((data) => PostModel.fromJson(data as Map<String, dynamic>))
              .skip(skipCount)
              .where((postModel) {
            final postId = postModel.postId;
            return !shownIds.contains(postId);
          })
              .map((postModel) => postModel.toEntity())
              .toList();

          developer.log('Filtered ${posts.length} posts for $category');
          allPosts.addAll(posts);
        }
      }

      allPosts.shuffle();
      developer.log('Total posts after shuffle: ${allPosts.length}');
      return right(allPosts);
    } catch (e) {
      developer.log('getPostsByModelScores failed with error: $e', level: 1000);
      return left(ServerFailure(errMessage: e.toString()));
    }
  }




  @override
  Future<Either<Failure, void>> addPost({required PostEntity post}) async {
    developer.log('addPost started for postId: ${post.postId}');
    try {
      await databaseService.addData(
          path: post.tag.toLowerCase(),
          documentId: post.postId,
          data: PostModel.fromEntity(post).toJson());

      developer.log('addPost succeeded for postId: ${post.postId}');
      await incrementPostCount(post.tag.toLowerCase());

      return right(null);
    } catch (e) {
      developer.log('addPost failed with error: $e', level: 1000);
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addComment({
    required CommentEntity comment,
    required PostEntity post,
  }) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        developer.log('No internet connection');
        return Left(ServerFailure(errMessage: 'No internet connection'));
      }
      await databaseService.updateData(
        path: post.tag.toLowerCase(),
        documentId: post.postId,
        data: {
          'comments': FieldValue.arrayUnion(
            [CommentModel.fromEntity(comment).toJson()],
          ),
        },
      );

      await localCounterService.increment(localCounterService.getKey(post.tag, 'comments'));

      developer.log('addComment succeeded for postId: ${post.postId}');
      return right(null);
    } catch (e) {
      developer.log('addComment failed with error: $e', level: 1000);
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addLike({
    required PostEntity post,
    required String userId,
  }) async {
    developer.log('addLike started for postId: ${post.postId}, userId: $userId');
    developer.log('Tag value: ${post.tag}');
    developer.log('PostId value: ${post.postId}');
    developer.log('Firestore instance initialized: ${FirebaseFirestore.instance.app != null}');
    try {
      final postRef = FirebaseFirestore.instance
          .collection(post.tag.toLowerCase())
          .doc(post.postId);

      final alreadyLiked = post.likedBy.contains(userId);
      developer.log('User already liked post: $alreadyLiked');

      if (alreadyLiked) {
        await postRef.update({
          'likedBy': FieldValue.arrayRemove([userId]),
          'likesCount': FieldValue.increment(-1),
        });
        await localCounterService.decrement(localCounterService.getKey(post.tag, 'likes'));
        developer.log('Removed like for postId: ${post.postId}');
      } else {
        await postRef.update({
          'likedBy': FieldValue.arrayUnion([userId]),
          'likesCount': FieldValue.increment(1),
        });
        await localCounterService.increment(localCounterService.getKey(post.tag, 'likes'));
        developer.log('Added like for postId: ${post.postId}');
      }

      return const Right(null);
    } catch (e) {
      developer.log('addLike failed with error: $e', level: 1000);
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  Future<void> saveSortedScoresToLocal(Map<String, double> scores) async {
    final prefs = await SharedPreferences.getInstance();

    final sortedList = scores.entries
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final jsonList = sortedList
        .map((entry) => jsonEncode({'key': entry.key, 'value': entry.value}))
        .toList();

    await prefs.setStringList('sorted_disease_scores', jsonList);
  }

  @override
  Future<Either<Failure, Map<String, double>>> getDiseaseScores() async {
    developer.log('getDiseaseScores started');
    try {
      final categories = ['heart', 'brain', 'lung', 'knee', 'neutral'];
      final Map<String, double> scores = {};

      final userId = getIt<UserCubit>().currentUser!.uId;



      double totalScore = 0.0;

      for (final category in categories) {
        final scanCount = await getScanCount(category)??0;
        final postCount = await getPostCount(category) ??0;
        final commentCount = await localCounterService.getCount(localCounterService.getKey(category, 'comments'));
        final likeCount = await localCounterService.getCount(localCounterService.getKey(category, 'likes'));

        final score = (scanCount * 2.5) +
            (postCount * 2.0) +
            (commentCount * 1.5) +
            likeCount;

        scores[category] = score;
        totalScore += score;

        developer.log('Score for $category: $score');
      }

      if (totalScore == 0) {
        developer.log('Total score is zero, returning zero scores');
        return right({for (var c in categories) c: 0.0});
      }

      final Map<String, double> normalizedScores = {
        for (var entry in scores.entries)
          entry.key: (entry.value / totalScore)
      };
      developer.log('Normalized scores: $normalizedScores');
      await saveSortedScoresToLocal(normalizedScores);
      return right(normalizedScores);
    } catch (e) {
      developer.log('getDiseaseScores failed with error: $e', level: 1000);
      return left(ServerFailure(errMessage: e.toString()));
    }
  }




}
