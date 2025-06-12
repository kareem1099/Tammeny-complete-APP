import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/features/home/presentation/manager/medical_news_cubit/medical_news_cubit.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/health_scan_categories_section.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/health_tips_section.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/home_view_custom_header.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/home_view_main_banner_section.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/latest_medical_news_sliver_list.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/latest_scans_bloc_builder.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/medical_articles_section.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/nearby_doctors_section.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/nearby_doctors_sliver_list_bloc_builder.dart';
import 'package:tamenny_app/generated/l10n.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<MedicalNewsCubit>().getMedicalNews();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const HomeViewMainBannerSection(),
          const HealthScanCategoriesSection(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeViewCustomHeader(text: S.of(context).yourRecentInsights),
              ],
            ),
          ),
          // TODO : عدل هنا ظهور الالفحوصات علي حسب اللي موجود ف الليست لو فاضيه متظهرهاش خالص
          if (false) const LatestScansBlocBuilder(),
          const NearbyDoctorsSection(),
          const NearbyDoctorsSliverListBlocBuilder(),
          const HealthTipsSection(),
          const MedicalArticlesSection(),
          const SliverMedicalArticlesList(),
        ],
      ),
    );
  }
}
