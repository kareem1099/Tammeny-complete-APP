import 'package:dartz/dartz.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/models/diagnosis_result_model.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/utils/backend_end_point.dart';
import 'package:tamenny_app/features/home/domain/repos/latest_scans_repo.dart';

class LatestScansRepoImpl implements LatestScansRepo {
  final DatabaseService databaseService;

  LatestScansRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<DiagnosisResultEntity>>> fetchLatestScans(
      {required String userId}) async {
    try {
      Map<String, dynamic> user = await databaseService.getData(
          path: BackendEndPoint.getUserData, documentId: userId);
     List<DiagnosisResultEntity>? diagnoses =
          (user['diagnoses'] as List<dynamic>?)?.map((diagnosis) {
        return DiagnosisResultModel.fromJson(diagnosis as Map<String, dynamic>)
            .toEntity();
      }).toList();
      return right(diagnoses ?? []);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
