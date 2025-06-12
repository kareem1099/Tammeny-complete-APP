import 'package:flutter/material.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/features/home/presentation/views/latest_scan_result_view.dart';

class LatestScansSliverGrid extends StatelessWidget {
  const LatestScansSliverGrid({super.key, required this.diagnosis});
  final List<DiagnosisResultEntity> diagnosis;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
      itemCount: diagnosis.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (_) => const LatestScanResultView(
                      status: 'normal',
                      resultDescription:
                          'No health issues were detected in this scan.',
                      adviceList: [
                        'Maintain a healthy diet.',
                        'Keep doing regular light exercises.',
                        'Continue your periodic health check-ups.',
                      ],
                    )));
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.file_present, color: Colors.blue, size: 40),
                const Spacer(),
                Text(
                  "Scan ${index + 1}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  "Status: Normal",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
