import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:tamenny_app/features/auth/domain/repos/auth_repo.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());

  final AuthRepo authRepo;

  forgotPassword({required String email}) async {
    emit(ForgotPasswordLoading());
    var result = await authRepo.forgotPassword(email: email);
    result.fold((f) => emit(ForgotPasswordFailure(errMessage: f.errMessage)),
        (d) => emit(ForgotPasswordSuccess()));
  }
}
