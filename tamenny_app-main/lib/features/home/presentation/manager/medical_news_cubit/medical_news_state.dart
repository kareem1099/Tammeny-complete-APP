part of 'medical_news_cubit.dart';

@immutable
sealed class MedicalNewsState {}

final class MedicalNewsInitial extends MedicalNewsState {}

final class MedicalNewsLoading extends MedicalNewsState {}

final class MedicalNewsSuccess extends MedicalNewsState {
  final List<ArticleEntity> articles;

  MedicalNewsSuccess({
    required this.articles,
  });
}

final class MedicalNewsFailure extends MedicalNewsState {
  final String errMessage;

  MedicalNewsFailure({
    required this.errMessage,
  });
}
