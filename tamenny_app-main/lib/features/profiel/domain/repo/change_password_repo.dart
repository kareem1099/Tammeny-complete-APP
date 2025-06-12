import 'package:dartz/dartz.dart';
import 'package:tamenny_app/core/errors/failure.dart';

abstract class ChangePasswordRepo {
  Future<Either<Failure, void>> changePassword(
      {required String currentPassword, required String newPassword});
}
