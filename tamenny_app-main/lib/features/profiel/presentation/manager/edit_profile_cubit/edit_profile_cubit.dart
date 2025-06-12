import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/services/storage_service.dart';
import 'package:tamenny_app/core/utils/backend_end_point.dart';
import 'package:tamenny_app/features/auth/data/models/user_model.dart';
import 'package:tamenny_app/features/profiel/presentation/manager/edit_profile_cubit/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.storageService, this.databaseService)
      : super(EditProfileInitial());

  final StorageService storageService;
  final DatabaseService databaseService;

  final ImagePicker _picker = ImagePicker();
  final userCubit = getIt<UserCubit>();

  // Future<void> editProfileAvatar(String userId, XFile file) async {
  //   try {
  //     emit(EditProfileLoading());

  //     String fileName =
  //         '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
  //     String path = 'avatars/$fileName';

  //     final imageUrl = await storageService.uploadFile(file: file, path: path);
  //     await databaseService.updateUserAvatar(
  //         userId: userId, imageUrl: imageUrl);

  //     final userBox = Hive.box<UserModel>('user');
  //     final currentUser = userBox.get('currentUser');

  //     if (currentUser != null) {
  //       final updatedUser = currentUser.copyWith(userAvatarUrl: imageUrl);
  //       await userBox.put('currentUser', updatedUser);
  //       userCubit.saveUser(updatedUser);
  //     }
  //     emit(EditProfileSuccess(imageUrl));
  //   } catch (e) {
  //     emit(EditProfileError(e.toString()));
  //   }
  // }

  // Future<void> updateUsername(String userId, String newUsername) async {
  //   emit(EditProfileLoading());
  //   try {
  //     await databaseService.updateData(
  //         path: BackendEndPoint.updateUserData,
  //         documentId: userId,
  //         data: {
  //           'name': newUsername,
  //         });
  //     emit(EditProfileSuccess('')); // null imageUrl since no image change
  //   } catch (e) {
  //     emit(EditProfileError(e.toString()));
  //   }
  // }

  // Future<void> updateEmail(String newEmail) async {
  //   emit(EditProfileLoading());
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       await user.updateEmail(newEmail);
  //       await user.reload(); // refresh user data
  //       emit(EditProfileSuccess(''));
  //     } else {
  //       emit(EditProfileError("User not logged in"));
  //     }
  //   } catch (e) {
  //     emit(EditProfileError(e.toString()));
  //   }
  // }

  Future<void> updateProfile({
    required String userId,
    XFile? newAvatar,
    String? newUsername,
    String? newEmail,
  }) async {
    await _performUpdate(userId, newAvatar, newUsername, newEmail);
  }

  Future<void> _performUpdate(
    String userId,
    XFile? newAvatar,
    String? newUsername,
    String? newEmail,
  ) async {
    emit(EditProfileLoading());

    try {
      String? imageUrl;

      if (newAvatar != null) {
        String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${newAvatar.path.split('/').last}';
        String path = 'avatars/$fileName';

        imageUrl = await storageService.uploadFile(file: newAvatar, path: path);
        await databaseService.updateUserAvatar(
            userId: userId, imageUrl: imageUrl);
      }

      if (newUsername != null && newUsername.isNotEmpty) {
        await databaseService.updateData(
          path: BackendEndPoint.updateUserData,
          documentId: userId,
          data: {'name': newUsername},
        );
      }

      if (newEmail != null && newEmail.isNotEmpty) {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.verifyBeforeUpdateEmail(newEmail);
          await user.reload();
        } else {
          throw Exception("User not logged in");
        }
      }

      final userBox = Hive.box<UserModel>('user');
      final currentUser = userBox.get('currentUser');

      if (currentUser != null) {
        var updatedUser = currentUser;
        if (imageUrl != null) {
          updatedUser = updatedUser.copyWith(userAvatarUrl: imageUrl);
        }
        if (newUsername != null && newUsername.isNotEmpty) {
          updatedUser = updatedUser.copyWith(name: newUsername);
        }
        if (newEmail != null && newEmail.isNotEmpty) {
          updatedUser = updatedUser.copyWith(email: newEmail);
        }
        await userBox.put('currentUser', updatedUser);
        userCubit.saveUser(updatedUser);
      }

      emit(EditProfileSuccess(imageUrl ?? ''));
    } catch (e) {
      if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
        emit(EditProfileError('Please re-authenticate to update your email.'));
      } else {
        emit(EditProfileError(e.toString()));
      }
    }
  }
}
