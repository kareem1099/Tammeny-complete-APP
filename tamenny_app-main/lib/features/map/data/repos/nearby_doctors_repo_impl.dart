import 'package:dartz/dartz.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/models/doctor_model.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/utils/backend_end_point.dart';
import 'package:tamenny_app/features/map/domain/repos/nearby_doctors_repo.dart';

class NearbyDoctorsRepoImpl extends NearbyDoctorsRepo {
  final DatabaseService databaseService;

  NearbyDoctorsRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<DoctorEntity>>> fetchNearbyDoctors() async {
    try {
      var result =
          await databaseService.getData(path: BackendEndPoint.getDoctors);
      List<DoctorEntity> doctors = (result as List<Map<String, dynamic>>)
          .map((doctor) => DoctorModel.fromJson(doctor).toEntity())
          .toList();
      return right(doctors);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
