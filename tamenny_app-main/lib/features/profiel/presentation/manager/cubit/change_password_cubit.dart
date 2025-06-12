import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamenny_app/core/services/firebase_auth_service.dart';
import 'package:tamenny_app/features/profiel/domain/repo/change_password_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.changePasswordRepo, this.firebaseAuthService)
      : super(ChangePasswordInitial());

  final ChangePasswordRepo changePasswordRepo;
  final FirebaseAuthService firebaseAuthService;

  changePassword(
      {required String enteredPassword, required String newPassword}) async {
    emit(ChangePasswordLoading());

    var result = await changePasswordRepo.changePassword(
        currentPassword: enteredPassword, newPassword: newPassword);
    result.fold(
        (f) => emit(ChangePasswordFailure(errMessage: f.errMessage)),
        (v) => emit(
              ChangePasswordSuccess(),
            ));
  }
}
