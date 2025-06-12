import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/services/firebase_auth_service.dart';
import 'package:tamenny_app/features/profiel/domain/repo/change_password_repo.dart';

class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final FirebaseAuthService firebaseAuthService;

  ChangePasswordRepoImpl(this.firebaseAuthService);
  @override
  Future<Either<Failure, void>> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      bool verifiedPassword =
          await firebaseAuthService.checkPassword(currentPassword);
      if (verifiedPassword) {
        await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      } else {
        throw Exception('verified password is $verifiedPassword and cant go');
      }

      return right(null);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
