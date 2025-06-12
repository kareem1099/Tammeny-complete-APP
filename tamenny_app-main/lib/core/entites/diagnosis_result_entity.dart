class DiagnosisResultEntity {
  final String diagnosisId;
  final String status; // e.g., 'normal', 'moderate', 'critical'
  final DateTime scannedAt;
  final String scanImageUrl;
  final String? diagnosisSummary;
  // final List<String> adviceList;

  DiagnosisResultEntity({
    required this.status,
    required this.scanImageUrl,
    required this.diagnosisId,
    required this.scannedAt,
     this.diagnosisSummary,
  });
}
