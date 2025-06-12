import 'package:dartz/dartz.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/core/errors/failure.dart';

abstract class LatestScansRepo {
  Future<Either<Failure, List<DiagnosisResultEntity>>> fetchLatestScans(
      {required String userId});
}
