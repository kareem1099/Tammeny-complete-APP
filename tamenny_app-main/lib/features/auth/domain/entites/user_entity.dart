import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';

class UserEntity {
  final String name;
  final String email;
  final String uId;
  String userAvatarUrl;
  final List<DiagnosisResultEntity>? diagnoses;

  UserEntity({
    this.userAvatarUrl =
        'https://hxknihxevezcsgfffdmr.supabase.co/storage/v1/object/public/images/avatars/profiel.png',
    required this.name,
    required this.email,
    required this.uId,
    this.diagnoses,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
    List<DiagnosisResultEntity>? diagnoses,
  }) {
    return UserEntity(
      uId: id ?? uId,
      name: name ?? this.name,
      email: email ?? this.email,
      userAvatarUrl: imageUrl ?? userAvatarUrl,
      diagnoses: diagnoses ?? this.diagnoses,
    );
  }
}
