import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:tamenny_app/features/auth/data/models/user_model.dart';

class UserCubit extends Cubit<UserModel?> {
  final Box<UserModel> userBox;

  UserCubit(this.userBox) : super(userBox.get('currentUser'));

  void saveUser(UserModel user) {
    userBox.put('currentUser', user);
    emit(user);
  }

  void clearUser() {
    userBox.delete('currentUser');
    emit(null);
  }

  UserModel? get currentUser => userBox.get('currentUser');
}
