import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/health_tips_list_view.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/home_view_custom_header.dart';
import 'package:tamenny_app/generated/l10n.dart';

class HealthTipsSection extends StatelessWidget {
  const HealthTipsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HomeViewCustomHeader(
          text: S.of(context).healthTipsForYou,
        ),
        const HealthTipsListView(),
      ],
    ));
  }
}
