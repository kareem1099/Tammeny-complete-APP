class ScanDetailsEntity {
  final String analysisTitle; // e.g., 'Lung Disease Analysis'
  final String analysisType;
  final String analysisGuidanceMessages;
  // final String? modelName;

  const ScanDetailsEntity({
    required this.analysisTitle,
    required this.analysisType,
    required this.analysisGuidanceMessages,
    // this.modelName,
  });
}
