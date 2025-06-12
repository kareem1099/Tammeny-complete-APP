import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:tamenny_app/core/errors/custom_exception.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/firebase_auth_service.dart';
import 'package:tamenny_app/core/utils/backend_end_point.dart';
import 'package:tamenny_app/features/auth/data/models/user_model.dart';
import 'package:tamenny_app/features/auth/domain/entites/user_entity.dart';
import 'package:tamenny_app/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl({
    required this.firebaseAuthService,
    required this.databaseService,
  });

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserEntity userEntity = UserEntity(
          name: name,
          email: email,
          uId: user.uid,
          userAvatarUrl:
              'https://hxknihxevezcsgfffdmr.supabase.co/storage/v1/object/public/images/avatars/profiel.png');
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);

      return left(ServerFailure(errMessage: e.toString()));
    } catch (e) {
      await deleteUser(user);
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword : ${e.toString()}',
      );
      return left(
        ServerFailure(errMessage: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.'),
      );
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserEntity userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(errMessage: e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signInWithEmailAndPassword : ${e.toString()}',
      );
      return left(
        ServerFailure(errMessage: 'لقد حدث خطأ ما. الرجاء المحاولة مرة اخرى.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();

      // Create user entity from Firebase user
      UserEntity userEntity = UserModel.fromFirebaseUser(user).toEntity();

      // Check if user exists in database
      var isUserExist = await databaseService.checkIfDataExists(
        path: BackendEndPoint.isUserExists,
        documentId: user.uid,
      );

      if (!isUserExist) {
        // If user doesn't exist, add them to the database
        await addUserData(user: userEntity);
      } else {
        // If user exists, get their data from the database
        userEntity = await getUserData(uid: user.uid);
      }

      // Save user data to local storage
      await saveUserData(user: userEntity);

      return right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      return left(
        ServerFailure(
            errMessage: 'Failed to sign in with Google. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      UserEntity userEntity = UserModel.fromFirebaseUser(user).toEntity();
      var isUserExist = await databaseService.checkIfDataExists(
        path: BackendEndPoint.isUserExists,
        documentId: user.uid,
      );
      if (!isUserExist) {
        await addUserData(user: userEntity);
      } else {
        userEntity = await getUserData(uid: user.uid);
      }
      await saveUserData(user: userEntity);
      return right(userEntity);
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithFacebook: ${e.toString()}');
      return left(
        ServerFailure(errMessage: 'Something happened'),
      );
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndPoint.addUserData,
      data: UserModel.fromEntity(user).toJson(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    return UserModel.fromJson(
      await databaseService.getData(
        path: BackendEndPoint.getUserData,
        documentId: uid,
      ),
    ).toEntity();
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    final userBox = Hive.box<UserModel>('user');
    await userBox.put('currentUser', UserModel.fromEntity(user));
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await firebaseAuthService.forgotPassword(email: email);
      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
