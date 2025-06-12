import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';

class DiagnosisResultModel {
  final String diagnosisId;
  final String status;
  final DateTime scannedAt;
  final String scanImageUrl;
  final String? diagnosisSummary;

  DiagnosisResultModel({
    required this.diagnosisId,
    required this.status,
    required this.scannedAt,
    required this.scanImageUrl,
     this.diagnosisSummary,
  });

  DiagnosisResultEntity toEntity() {
    return DiagnosisResultEntity(
      diagnosisId: diagnosisId,
      status: status,
      scannedAt: scannedAt,
      scanImageUrl: scanImageUrl,
      diagnosisSummary: diagnosisSummary,
    );
  }

  factory DiagnosisResultModel.fromEntity(DiagnosisResultEntity entity) {
    return DiagnosisResultModel(
      diagnosisId: entity.diagnosisId,
      status: entity.status,
      scannedAt: entity.scannedAt,
      scanImageUrl: entity.scanImageUrl,
      diagnosisSummary: entity.diagnosisSummary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diagnosisId': diagnosisId,
      'status': status,
      'scannedAt': scannedAt.toIso8601String(),
      'scanImageUrl': scanImageUrl,
      'resultDescription': diagnosisSummary,
    };
  }

  factory DiagnosisResultModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisResultModel(
      diagnosisId: json['diagnosisId'],
      status: json['status'],
      scannedAt: DateTime.parse(json['scannedAt']),
      scanImageUrl: json['scanImageUrl'],
      diagnosisSummary: json['diagnosisSummary'],
    );
  }
}
