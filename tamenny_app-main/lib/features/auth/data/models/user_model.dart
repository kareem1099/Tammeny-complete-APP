import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/core/models/diagnosis_result_model.dart';
import 'package:tamenny_app/features/auth/domain/entites/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String userAvatarUrl;

  @HiveField(3)
  final String uId;

  @HiveField(4)
  final List<DiagnosisResultModel>? diagnoses;

  UserModel({
    required this.name,
    required this.email,
    required this.uId,
    required this.userAvatarUrl,
    this.diagnoses,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      name: user.displayName ?? '',
      email: user.email ?? '',
      uId: user.uid,
      userAvatarUrl: user.photoURL ?? '',
      diagnoses: [],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      uId: json['uId'],
      userAvatarUrl: json['userAvatarUrl'],
      diagnoses: json['diagnoses'] != null
          ? List<DiagnosisResultModel>.from(
              json['diagnoses'].map((x) => DiagnosisResultModel.fromJson(x)))
          : null,
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      name: user.name,
      email: user.email,
      uId: user.uId,
      userAvatarUrl: user.userAvatarUrl,
      diagnoses: user.diagnoses != null
          ? List<DiagnosisResultModel>.from(
              user.diagnoses!.map((x) => DiagnosisResultModel.fromEntity(x)))
          : null,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      name: name,
      email: email,
      uId: uId,
      userAvatarUrl: userAvatarUrl,
      diagnoses: diagnoses != null
          ? List<DiagnosisResultEntity>.from(
              diagnoses!.map((x) => x.toEntity()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uId": uId,
      "userAvatarUrl": userAvatarUrl,
      "diagnoses": diagnoses?.map((x) => x.toJson()).toList() ?? [],
    };
  }

  @override
  String toString() {
    return 'name => $name , email => $email , uid => $uId';
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? userAvatarUrl,
    String? uId,
    List<DiagnosisResultModel>? diagnoses,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      userAvatarUrl: userAvatarUrl ?? this.userAvatarUrl,
      uId: uId ?? this.uId,
      diagnoses: diagnoses ?? this.diagnoses,
    );
  }
}
