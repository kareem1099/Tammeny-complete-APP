import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/health_scan_categories_widget.dart';

class HealthScanCategoriesSection extends StatelessWidget {
  const HealthScanCategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: HealthScanCategoriesWidget(),
    );
  }
}
