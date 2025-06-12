import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:tamenny_app/core/recommendation_sys/recomm_model.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/firestore_service.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import '../../../../../core/errors/failure.dart';
import 'community_state.dart';
import 'dart:developer' as developer;

class CommunityCubit extends Cubit<CommunityState> {
  final RecommendationRepo recommendationRepo;
  final DiseasePriorityModel recommModel;
  final DatabaseService databaseService;
  CommunityCubit(
      this.recommendationRepo,
      this.recommModel,
      this.databaseService,
      ) : super(CommunityInitial()) {
    developer.log('CommunityCubit initialized', name: 'CommunityCubit');
  }

  StreamSubscription? _streamSubscription;

  bool isLoadingMore = false;
  Future<void> fetchPostsBasedonPrefrences({bool isLoadMore = false}) async {
    developer.log('fetchPostsBasedonPrefrences called, isLoadMore=$isLoadMore', name: 'CommunityCubit');

    if (isLoadMore) {
      if (isLoadingMore || state is! CommunitySuccess) {
        developer.log('Skipping load more: isLoadingMore=$isLoadingMore, state=$state', name: 'CommunityCubit');
        return;
      }
      isLoadingMore = true;
      developer.log('Loading more posts...', name: 'CommunityCubit');
    } else {
      emit(CommunityLoading());
      developer.log('Emitted CommunityLoading state', name: 'CommunityCubit');
    }

    try {
      final scoresMapEither = await recommendationRepo.getDiseaseScores();
      developer.log('Got disease scores from repo', name: 'CommunityCubit');

      if (scoresMapEither.isLeft()) {
        final failureMsg = scoresMapEither.swap().getOrElse(() => Failure(errMessage: "Unknown error")).toString();
        developer.log('Failed to get disease scores: $failureMsg', name: 'CommunityCubit', level: 1000);
        if (!isLoadMore) emit(CommunityFailure(failureMsg));
        return;
      }

      final scoresMap = scoresMapEither.getOrElse(() => {});
      final userRatios = [
        (scoresMap['heart'] ?? 0).toDouble(),
        (scoresMap['brain'] ?? 0).toDouble(),
        (scoresMap['lung'] ?? 0).toDouble(),
        (scoresMap['knee'] ?? 0).toDouble(),
        (scoresMap['neutral'] ?? 0).toDouble(),
      ];
      developer.log('User ratios prepared: $userRatios', name: 'CommunityCubit');

      final allZero = userRatios.every((ratio) => ratio == 0);

      final Map<String, String> categoryToCollection = {
        'heart': 'heart',
        'brain': 'brain',
        'lung': 'lung',
        'knee': 'knee',
        'neutral': 'neutral',
      };

      if (allZero) {
        developer.log('All user ratios are zero, fetching first 5 posts per category', name: 'CommunityCubit');

        List<PostEntity> allPosts = [];

        for (var category in categoryToCollection.keys) {
          final postsData = await databaseService.getData(
            path: categoryToCollection[category]!,
            query: {
              'orderBy': 'createdAt',
              'descending': true,
              'limit': 5,
            },
          );

          final posts = postsData.map<PostEntity>((postMap) {
            return PostEntity(
              postId: postMap['postId'] ?? '',
              userAvatarUrl: postMap['userAvatarUrl'] ?? '',
              username: postMap['username'] ?? '',
              createdAt: postMap['createdAt'],
              postText: postMap['postText'] ?? '',
              commentsCount: postMap['commentsCount'] ?? 0,
              likesCount: postMap['likesCount'] ?? 0,
              sharesCount: postMap['sharesCount'] ?? 0,
              likedBy: List<String>.from(postMap['likedBy'] ?? []),
              tag: category,
              comments: null,
              imageUrl: postMap['imageUrl'] ?? '',
            );
          }).toList();

          allPosts.addAll(posts);
        }

        emit(CommunitySuccess(allPosts));
        isLoadingMore = false;
        return;
      }

      Map<String, Set<String>> shownPostIdsPerCategory = {};
      Map<String, int> skippedCountsPerCategory = {};
      if (isLoadMore && state is CommunitySuccess) {
        final posts = (state as CommunitySuccess).posts;
        for (var post in posts) {
          final category = post.tag;
          shownPostIdsPerCategory.putIfAbsent(category, () => {}).add(post.postId);
          skippedCountsPerCategory[category] = (skippedCountsPerCategory[category] ?? 0) + 1;
        }
      }

      final modelInputEither = await recommendationRepo.buildModelInput(
        userRatios,
        shownPostIdsPerCategory,
      );

      if (modelInputEither.isLeft()) {
        final failureMsg = modelInputEither.swap().getOrElse(() => Failure(errMessage: "Unknown error")).toString();
        developer.log('Failed to build model input: $failureMsg', name: 'CommunityCubit', level: 1000);
        if (!isLoadMore) emit(CommunityFailure(failureMsg));
        return;
      }

      final modelInput = modelInputEither.getOrElse(() => <double>[]);

      final predictionResult = await recommModel.predict(modelInput);
      final predictionResultInt = predictionResult.map((e) => e.toInt()).toList();
      developer.log('Prediction result: $predictionResultInt', name: 'CommunityCubit');

      final postsEither = await recommendationRepo.getPostsByModelScores(
        predictionResultInt,
        databaseService,
        shownPostIdsPerCategory: shownPostIdsPerCategory,
        skippedCountsPerCategory: skippedCountsPerCategory,
      );

      postsEither.fold(
            (failure) {
          developer.log('Failed to get posts by model scores: $failure', name: 'CommunityCubit', level: 1000);
          if (!isLoadMore) emit(CommunityFailure(failure.toString()));
        },
            (newPosts) {
          developer.log('Successfully fetched new posts, count=${newPosts.length}', name: 'CommunityCubit');
          if (isLoadMore) {
            final oldPosts = (state as CommunitySuccess).posts;
            final uniqueNewPosts = newPosts.where((post) => !oldPosts.any((old) => old.postId == post.postId)).toList();
            final List<PostEntity> combined = [...oldPosts, ...uniqueNewPosts];
            emit(CommunitySuccess(combined));
          } else {
            emit(CommunitySuccess(newPosts));
          }
        },
      );
    } catch (e) {
      developer.log('Exception caught in fetchPostsBasedonPrefrences: $e', name: 'CommunityCubit', level: 1000);
      if (!isLoadMore) emit(CommunityFailure(e.toString()));
    }

    isLoadingMore = false;
  }

  Future<void> likePost({required PostEntity post, required String userId}) async {
    developer.log('likePost called for postId=${post.postId} by userId=$userId', name: 'CommunityCubit');
    final result = await recommendationRepo.addLike(post: post, userId: userId);
    result.fold(
          (failure) {
        developer.log('Failed to add like: $failure', name: 'CommunityCubit', level: 1000);
        emit(CommunityFailure(failure.toString()));
      },
          (_) {
        developer.log('Like added successfully, toggling like locally', name: 'CommunityCubit');
        toggleLikeInPost(postId: post.postId, userId: userId);
      },
    );
  }

  void toggleLikeInPost({required String postId, required String userId}) {
    developer.log('toggleLikeInPost called for postId=$postId, userId=$userId', name: 'CommunityCubit');

    if (state is CommunitySuccess) {
      final currentState = state as CommunitySuccess;
      final updatedPosts = currentState.posts.map((post) {
        if (post.postId == postId) {
          final likedBy = Set<String>.from(post.likedBy);
          if (likedBy.contains(userId)) {
            likedBy.remove(userId);
          } else {
            likedBy.add(userId);
          }
          return post.copyWith(likedBy: likedBy.toList());
        }
        return post;
      }).toList();

      emit(CommunitySuccess(updatedPosts));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
