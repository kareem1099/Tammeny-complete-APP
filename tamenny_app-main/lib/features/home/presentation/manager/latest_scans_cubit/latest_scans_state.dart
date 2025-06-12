part of 'latest_scans_cubit.dart';

@immutable
sealed class LatestScansState {}

final class LatestScansInitial extends LatestScansState {}

final class LatestScansLoading extends LatestScansState {}

final class LatestScansSuccess extends LatestScansState {
  final List<DiagnosisResultEntity> diagnosis;

  LatestScansSuccess({
    required this.diagnosis,
  });
}

final class LatestScansFailure extends LatestScansState {
  final String errMessage;

  LatestScansFailure({
    required this.errMessage,
  });
}
