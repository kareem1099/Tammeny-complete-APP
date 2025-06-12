import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/core/widgets/custom_error_widget.dart';
import 'package:tamenny_app/features/home/presentation/manager/latest_scans_cubit/latest_scans_cubit.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/latest_scans_sliver_grid.dart';

class LatestScansBlocBuilder extends StatelessWidget {
  const LatestScansBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestScansCubit, LatestScansState>(
      builder: (context, state) {
        if (state is LatestScansSuccess) {
          if (state.diagnosis.isEmpty) {
            return const SliverToBoxAdapter(
                child: CustomErrorWidget(errMessage: 'noting here'));
          } else {
            return LatestScansSliverGrid(
              diagnosis: state.diagnosis,
            );
          }
        } else if (state is LatestScansFailure) {
          return SliverToBoxAdapter(
              child: CustomErrorWidget(errMessage: state.errMessage));
        } else {
          return Skeletonizer.sliver(
              enabled: true,
              child: LatestScansSliverGrid(
                diagnosis: dummyDiagnoses,
              ));
        }
      },
    );
  }
}

final List<DiagnosisResultEntity> dummyDiagnoses = [
  DiagnosisResultEntity(
    diagnosisId: 'dx1',
    status: 'normal',
    scanImageUrl: 'https://example.com/scan1.jpg',
    scannedAt: DateTime.now().subtract(const Duration(days: 3)),
    diagnosisSummary:
        'No health issues were detected in this scan. Continue regular check-ups and maintain a healthy lifestyle.',
  ),
  DiagnosisResultEntity(
    diagnosisId: 'dx2',
    status: 'benign',
    scanImageUrl: 'https://example.com/scan2.jpg',
    scannedAt: DateTime.now().subtract(const Duration(days: 10)),
    diagnosisSummary:
        'Detected tissue is benign. Routine follow-up and clinical evaluation are recommended.',
  ),
  DiagnosisResultEntity(
    diagnosisId: 'dx3',
    status: 'malignant',
    scanImageUrl: 'https://example.com/scan3.jpg',
    scannedAt: DateTime.now().subtract(const Duration(days: 20)),
    diagnosisSummary:
        'Scan indicates malignant tissue. Immediate medical consultation is advised.',
  ),
  DiagnosisResultEntity(
    diagnosisId: 'dx3',
    status: 'malignant',
    scanImageUrl: 'https://example.com/scan3.jpg',
    scannedAt: DateTime.now().subtract(const Duration(days: 20)),
    diagnosisSummary:
        'Scan indicates malignant tissue. Immediate medical consultation is advised.',
  ),
];
