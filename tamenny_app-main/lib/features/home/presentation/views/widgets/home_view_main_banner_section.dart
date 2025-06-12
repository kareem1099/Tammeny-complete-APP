import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/home_custom_app_bar.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/main_banner_widget.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/search_text_field_with_routing_widget.dart';

class HomeViewMainBannerSection extends StatelessWidget {
  const HomeViewMainBannerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeCustomAppBar(),
          SizedBox(
            height: 16,
          ),
          SearchTextFieldWithRouting(),
          SizedBox(
            height: 12,
          ),
          MainBannerWidget(),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
