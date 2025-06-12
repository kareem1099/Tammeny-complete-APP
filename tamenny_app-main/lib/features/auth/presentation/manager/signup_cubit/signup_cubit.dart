import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tamenny_app/features/auth/domain/entites/user_entity.dart';
import 'package:tamenny_app/features/auth/domain/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this._authRepo) : super(SignupInitial());

  final AuthRepo _authRepo;

  createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());
    var result = await _authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(SignupFailure(errMessage: failure.errMessage)),
      (userEntity) => emit(SignupSuccess(userEntity: userEntity)),
    );
  }
}
