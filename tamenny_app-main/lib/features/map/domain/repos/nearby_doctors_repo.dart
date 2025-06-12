import 'package:dartz/dartz.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/errors/failure.dart';

abstract class NearbyDoctorsRepo {
  Future<Either<Failure, List<DoctorEntity>>> fetchNearbyDoctors();
}
