
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';

abstract class DiagnosisRepo {
  Future<Either<Failure, DiagnosisResultEntity>> startDiagnosis(
      {required XFile image,required String tag});

  Future addDiagnosisToFireStore(
      {required String userId, required Map<String, dynamic> diagnosis});

  Future addDignosisImageToSupabase(
      {required String userId, required XFile image});
}
