import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/features/community/domain/entites/comment_entity.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit(this.communityRepo, this.databaseService)
      : super(AddCommentInitial());

  final RecommendationRepo communityRepo;
  final DatabaseService databaseService;
  late String commentText;

  addComment({required PostEntity post}) async {
    final currentUser = getIt<UserCubit>().currentUser;
    if (currentUser == null) {
      emit(AddCommentFailure(errMessage: 'User is not logged in.'));
      return;
    }

    CommentEntity newComment = CommentEntity(
      username: currentUser.name,
      comment: commentText,
      avatarUrl: currentUser.userAvatarUrl,
    );

    emit(AddCommentLoading());

    var result = await communityRepo.addComment(comment: newComment, post: post);

    result.fold(
          (failure) {
        emit(AddCommentFailure(errMessage: failure.errMessage));
      },
          (_) {
        post.comments ??= [];
        post.comments!.add(newComment);

        databaseService.updateData(
          path: post.tag,
          documentId: post.postId,
          data: {'commentsCount': post.comments!.length},
        );

        emit(AddCommentSuccess());
      },
    );
  }
}
