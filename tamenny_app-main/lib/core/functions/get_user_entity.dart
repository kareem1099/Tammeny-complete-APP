import 'dart:convert';

import 'package:tamenny_app/config/cache_helper.dart';
import 'package:tamenny_app/constants.dart';
import 'package:tamenny_app/features/auth/data/models/user_model.dart';
import 'package:tamenny_app/features/auth/domain/entites/user_entity.dart';

UserEntity getUserEntitiy() {
  var jsonString = CacheHelper.getString(key: kUserData);
  var userEntitiy = UserModel.fromJson(jsonDecode(jsonString!)).toEntity();
  return userEntitiy;
}

void updateUserImageUrl(String newImageUrl) {
  final jsonString = CacheHelper.getString(key: kUserData);
  if (jsonString == null) return;

  final userEntity = UserModel.fromJson(jsonDecode(jsonString)).toEntity();

  userEntity.userAvatarUrl = newImageUrl;

  final updatedJsonString =
      jsonEncode(UserModel.fromEntity(userEntity).toJson());
  CacheHelper.set(key: kUserData, value: updatedJsonString);
}
