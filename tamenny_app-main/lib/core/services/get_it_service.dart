import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/recommendation_sys/recomm_model.dart';
import 'package:tamenny_app/core/services/local_count_service.dart';
import 'package:tamenny_app/core/services/medical_news_api_service.dart';
import 'package:tamenny_app/core/services/ai_diagnosis_service.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/firebase_auth_service.dart';
import 'package:tamenny_app/core/services/firestore_service.dart';
import 'package:tamenny_app/core/services/post_tag_prediction_service.dart';
import 'package:tamenny_app/core/services/storage_service.dart';
import 'package:tamenny_app/core/services/supabase_storage_service.dart';
import 'package:tamenny_app/features/auth/data/models/user_model.dart';
import 'package:tamenny_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:tamenny_app/features/auth/domain/repos/auth_repo.dart';
import 'package:tamenny_app/features/community/data/repos/recommendation_repo_impl.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import 'package:tamenny_app/features/home/data/repos/latest_scans_repo_impl.dart';
import 'package:tamenny_app/features/home/data/repos/medical_news_repo_impl.dart';
import 'package:tamenny_app/features/home/domain/repos/latest_scans_repo.dart';
import 'package:tamenny_app/features/home/domain/repos/medical_news_repo.dart';
import 'package:tamenny_app/features/map/data/repos/nearby_doctors_repo_impl.dart';
import 'package:tamenny_app/features/map/domain/repos/nearby_doctors_repo.dart';
import 'package:tamenny_app/features/profiel/data/repo/change_password_repo_impl.dart';
import 'package:tamenny_app/features/profiel/domain/repo/change_password_repo.dart';
import 'package:tamenny_app/features/scan/data/repos/diagnosis_repo_impl.dart';
import 'package:tamenny_app/features/scan/domain/repos/diagnosis_repo.dart';

import 'chatbot_service.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  final userBox = await Hive.openBox<UserModel>('user');

  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<StorageService>(SupabaseStorageService());
  getIt.registerSingleton<AIDiagnosisService>(AIDiagnosisService(Dio()));
  getIt.registerSingleton<PredictionService>(PredictionService());
  getIt.registerSingleton<LocalCounterService>(LocalCounterService());
  getIt.registerSingleton<chatService>(chatService());

  getIt.registerLazySingletonAsync<DiseasePriorityModel>(() async {
    final model = DiseasePriorityModel();
    await model.loadModel();
    return model;
  });

  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuthService: getIt<FirebaseAuthService>(),
      databaseService: getIt<DatabaseService>(),
    ),
  );



  getIt.registerSingleton<ChangePasswordRepo>(
    ChangePasswordRepoImpl(getIt<FirebaseAuthService>()),
  );

  getIt.registerSingleton<MedicalNewsApiService>(
    MedicalNewsApiService(Dio()),
  );

  getIt.registerSingleton<MedicalNewsRepo>(
    MedicalNewsRepoImpl(getIt<MedicalNewsApiService>()),
  );

  // 👉 NOTE: this depends on DiseasePriorityModel so you need to wait for it before use
  getIt.registerSingletonAsync<RecommendationRepo>(() async {
    final model = await getIt.getAsync<DiseasePriorityModel>();
    return RecommendationRepoImpl(
      getIt<DatabaseService>(),
      model,
      getIt<LocalCounterService>()
    );
  });

  getIt.registerSingleton<NearbyDoctorsRepo>(
    NearbyDoctorsRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerSingleton<DiagnosisRepo>(
    DiagnosisRepoImpl(
      getIt<AIDiagnosisService>(),
      getIt<DatabaseService>(),
      getIt<StorageService>(),
    ),
  );

  getIt.registerSingleton<LatestScansRepo>(
    LatestScansRepoImpl(getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton(() => RouteObserver<PageRoute>());

  getIt.registerLazySingleton(() => userBox);
  getIt.registerLazySingleton(() => UserCubit(getIt<Box<UserModel>>()));
}
