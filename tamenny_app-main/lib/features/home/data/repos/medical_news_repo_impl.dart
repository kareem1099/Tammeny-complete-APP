import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/services/medical_news_api_service.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import 'package:tamenny_app/features/home/data/models/article_model.dart';
import 'package:tamenny_app/features/home/domain/entites/article_entity.dart';
import 'package:tamenny_app/features/home/domain/repos/medical_news_repo.dart';

class MedicalNewsRepoImpl extends MedicalNewsRepo {
  final MedicalNewsApiService _medicalNewsApiService;

  MedicalNewsRepoImpl(this._medicalNewsApiService);

  Future<List<MapEntry<String, double>>> loadSortedScores() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('sorted_disease_scores');

    if (jsonList == null) return [];

    final scores = jsonList
        .map((jsonStr) {
      final map = jsonDecode(jsonStr);
      return MapEntry<String, double>(
        map['key'],
        map['value'].toDouble(),
      );
    })
        .where((entry) => entry.key != 'neutral')
        .toList();

    return scores;
  }


  @override
  Future<Either<Failure, List<ArticleEntity>>> getLatestMedicalNews() async {
    try {
      final scores = await loadSortedScores();
      final data;
      if (scores.isEmpty) {  data = await _medicalNewsApiService.get("news");}

      else{



         data = await _medicalNewsApiService.get(scores.first.key);
        log('API response: ${data.toString()}');


}

      final rawList = data['articles'] as List<dynamic>? ?? [];

      final List<ArticleEntity> articles = rawList
          .map((e) =>
          ArticleModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();

      return right(articles);
    } catch (e) {
      log('MedicalNewsRepoImpl => {getLatestMedicalNews} => ${e.toString()}');
      return left(ServerFailure(errMessage: e.toString()));
    }
  }









  }

