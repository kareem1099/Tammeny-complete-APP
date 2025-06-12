import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/errors/failure.dart';
import 'package:tamenny_app/core/services/ai_diagnosis_service.dart';
import 'package:tamenny_app/core/services/database_service.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/services/storage_service.dart';
import 'package:tamenny_app/core/utils/backend_end_point.dart';
import 'package:tamenny_app/core/models/diagnosis_result_model.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/features/scan/domain/repos/diagnosis_repo.dart';
import 'package:uuid/uuid.dart';

class DiagnosisRepoImpl extends DiagnosisRepo {
  final AIDiagnosisService aiDiagnosisService;
  final DatabaseService databaseService;
  final StorageService storageService;

  DiagnosisRepoImpl(
    this.aiDiagnosisService,
    this.databaseService,
    this.storageService,
  );

  @override
  Future<void> addDiagnosisToFireStore({
    required String userId,
    required Map<String, dynamic> diagnosis,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'diagnoses': FieldValue.arrayUnion([diagnosis]),
      }, SetOptions(merge: true)); // Merges with the existing document
    } catch (e) {
      print("Error adding diagnosis to Firestore: $e");
      rethrow;
    }
  }

  @override
  Future<Either<Failure, DiagnosisResultEntity>> startDiagnosis({
    required XFile image, required String tag
  }) async {
    try {
      final userId = getIt<UserCubit>().currentUser!.uId;

      final Map<String, dynamic> result =
          await aiDiagnosisService.Diagnosis(imageFile: File(image.path),diagnosisTag:
          tag);

      final String diagnosisResult = result['result'] ?? 'Unknown';
      String diagnosisSummary;

      if (diagnosisResult == 'Malignant') {
        diagnosisSummary =
            'The AI model has analyzed the lung scan and identified the findings as malignant. This suggests the presence of potentially cancerous tissue that may require immediate medical attention and further diagnostic evaluation by a healthcare professional. Early intervention can be critical for effective treatment planning.';
      } else if (diagnosisResult == 'Benign') {
        diagnosisSummary =
            'The AI model has analyzed the lung scan and identified the findings as benign. This indicates that the detected tissue or nodule is non-cancerous and does not currently show signs of malignancy. However, routine follow-up and clinical evaluation are recommended to ensure ongoing health and monitoring.';
      } else {
        diagnosisSummary = '';
      }

      final String scanImageUrl = await addDignosisImageToSupabase(
        userId: userId,
        image: image,
      );

      final diagnosis = DiagnosisResultEntity(
        status: diagnosisResult,
        scanImageUrl: scanImageUrl,
        diagnosisId: const Uuid().v4(),
        scannedAt: DateTime.now(),
        diagnosisSummary: diagnosisSummary,
      );

      await addDiagnosisToFireStore(
        userId: userId,
        diagnosis: DiagnosisResultModel.fromEntity(diagnosis).toJson(),
      );

      // final userCubit = getIt<UserCubit>();
      // final currentUser = userCubit.currentUser;

      // if (currentUser != null) {
      //   final updatedDiagnoses = List<DiagnosisResultModel>.from(
      //     currentUser.diagnoses ?? [],
      //   )..add(DiagnosisResultModel.fromEntity(diagnosis));

      //   final updatedUser = currentUser.copyWith(diagnoses: updatedDiagnoses);

      //   userCubit.saveUser(updatedUser);
      // }

      return Right(diagnosis);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<String> addDignosisImageToSupabase({
    required String userId,
    required XFile image,
  }) async {
    try {
      final imageUrl = await storageService.uploadFile(
        file: image,
        path: BackendEndPoint.addDiagnosisImage,
      );
      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image to Supabase: $e');
    }
  }
}
