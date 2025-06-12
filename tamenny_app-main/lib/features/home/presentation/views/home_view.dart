import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/features/community/domain/repos/Recommendation_repo.dart';
import 'package:tamenny_app/features/home/domain/repos/latest_scans_repo.dart';
import 'package:tamenny_app/features/home/domain/repos/medical_news_repo.dart';
import 'package:tamenny_app/features/home/presentation/manager/latest_scans_cubit/latest_scans_cubit.dart';
import 'package:tamenny_app/features/home/presentation/manager/medical_news_cubit/medical_news_cubit.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final recommendationRepo = getIt<RecommendationRepo>();

  @override
  void initState() {
    super.initState();
    fetchDiseaseScore();
  }

  Future<void> fetchDiseaseScore() async {
    final score = await recommendationRepo.getDiseaseScores();
    debugPrint('Fetched disease score: $score');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MedicalNewsCubit(
            getIt<MedicalNewsRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
          LatestScansCubit(getIt<LatestScansRepo>())..fetchLatestScans(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: isDark ? AppColors.darkBackgroundColor : Colors.white,
          systemNavigationBarColor:
          isDark ? AppColors.darkBackgroundColor : Colors.white,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
        ),
        child: const SafeArea(
          child: Scaffold(
            body: HomeViewBody(),
          ),
        ),
      ),
    );
  }
}
