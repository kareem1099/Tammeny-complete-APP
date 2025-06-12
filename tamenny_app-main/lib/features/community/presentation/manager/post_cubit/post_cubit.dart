import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/services/storage_service.dart';
import 'package:tamenny_app/features/community/domain/entites/post_entity.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import 'dart:io';

import 'package:tamenny_app/features/community/presentation/manager/post_cubit/post_state.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/services/post_tag_prediction_service.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(
      this._predictionService,
      this.communityRepo,
    this.storageService,
  ) : super(AddPostInitial());
  final PredictionService _predictionService;

  final RecommendationRepo communityRepo;
  final StorageService storageService;

  Future<void> postNow({
    required String postText,
    File? selectedImage,
    String? imageUrl,
  }) async {
    try {
      emit(AddPostLoading());
      final tagResult = await _predictionService.predict(postText);
      final tag = tagResult ?? 'general';
      print('Predicted Tag: $tag');

      String? imageUrl;
      if (selectedImage != null) {
        imageUrl = await _uploadImageToStorage(selectedImage);
      }

      await communityRepo.addPost(
          post: PostEntity(
        postId: const Uuid().v4(),
        postText: postText.trim(),
        username: getIt<UserCubit>().currentUser!.name,
        userAvatarUrl: getIt<UserCubit>().currentUser!.userAvatarUrl,
        commentsCount: 0,
        likesCount: 0,
        sharesCount: 0,
        createdAt: Timestamp.now(),
        imageUrl: imageUrl,
        likedBy: [],
        tag: tag,
      ));

      emit(AddPostSuccess());
    } catch (e) {
      emit(AddPostFailure(error: e.toString()));
    }
  }

  Future<String?> _uploadImageToStorage(File imageFile) async {
    final imageUrl = await storageService.uploadFile(
        file: XFile(imageFile.path), path: 'postsImages/');

    return imageUrl;
  }
}
