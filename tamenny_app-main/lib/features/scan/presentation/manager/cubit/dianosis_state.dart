import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';

class DiagnosisState {}

final class DiagnosisInitial extends DiagnosisState {}

final class DiagnosisLoading extends DiagnosisState {}

final class DiagnosisSuccess extends DiagnosisState {
  final DiagnosisResultEntity diagnosisResultEntity;

  DiagnosisSuccess({
    required this.diagnosisResultEntity,
  });
}

final class DiagnosisFailure extends DiagnosisState {
  final String errMessage;

  DiagnosisFailure({required this.errMessage});
}
