import 'package:dartz/dartz.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/features/home/domain/entites/article_entity.dart';

abstract class MedicalNewsRepo {
  Future<Either<Failure, List<ArticleEntity>>> getLatestMedicalNews();
}
