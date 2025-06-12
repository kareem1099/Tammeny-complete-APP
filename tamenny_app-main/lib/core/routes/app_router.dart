import 'package:flutter/material.dart';
import 'package:tamenny_app/core/entites/doctor_entity.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/features/community/presentation/views/add_post_view.dart';
import 'package:tamenny_app/features/home/domain/entites/article_entity.dart';
import 'package:tamenny_app/features/home/presentation/views/latest_medical_news_view.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/home_bottom_nav_bar.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/nearby_doctors_list_view.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:tamenny_app/features/onboarding/presentation/views/welcome_view.dart';
import 'package:tamenny_app/features/profiel/presentation/views/profile_change_password_view.dart';
import 'package:tamenny_app/features/profiel/presentation/views/profile_privacy_center_app_view.dart';
import 'package:tamenny_app/core/entites/diagnosis_result_entity.dart';
import 'package:tamenny_app/features/scan/domain/entites/scan_details_entity.dart';

import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/auth/presentation/views/signup_view.dart';
import '../../features/chatbot/presentation/views/chat_bot_view.dart';
import '../../features/home/presentation/views/notification_view.dart';
import '../../features/profiel/presentation/views/personal_info_view.dart';
import '../../features/scan/presentation/views/preview_scan_view.dart';
import '../../features/profiel/presentation/views/profile_faq_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/scan/presentation/views/completed_view.dart';
import '../../features/scan/presentation/views/scan_analysis_results.dart';
import '../../features/scan/presentation/views/scan_view.dart';
import '../../features/scan/presentation/views/upload_file_view.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case Routes.onboardingView:
        return MaterialPageRoute(
          builder: (context) => const OnboardingView(),
        );
      case Routes.welcomeView:
        return MaterialPageRoute(
          builder: (context) => const WelcomeView(),
        );
      case Routes.scanView:
        return MaterialPageRoute(
          builder: (context) => ScanView(
            scanDetailsEntity: settings.arguments as ScanDetailsEntity,
          ),
        );
      case Routes.loginView:
        return MaterialPageRoute(
          builder: (context) => const SigninView(),
        );
      case Routes.signupView:
        return MaterialPageRoute(
          builder: (context) => const SignUpView(),
        );
      case Routes.forgotPasswordView:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView(),
        );
      case Routes.bottomNavBarView:
        return MaterialPageRoute(
          builder: (context) => const BottomNavBar(),
        );
      case Routes.uploadFileView:
        return MaterialPageRoute(
          builder: (context) =>  UploadFileView(
            title: settings.arguments as String ,
          ),
        );

      case Routes.notificationView:
        return MaterialPageRoute(
          builder: (context) => const NotificationView(),
        );
      case Routes.completedScreen:
        return MaterialPageRoute(
          builder: (context) => CompletedView(
            diagnosisResultEntity: settings.arguments as DiagnosisResultEntity,
          ),
        );
      case Routes.scanAnalysisResultsScreen:
        return MaterialPageRoute(
          builder: (context) => ScanAnalysisResults(
            diagnosisResultEntity: settings.arguments as DiagnosisResultEntity,
          ),
        );
      case Routes.profileChangePasswordView:
        return MaterialPageRoute(
          builder: (context) => const ProfileChangePasswordView(),
        );
      case Routes.profilePrivacyCenterApp:
        return MaterialPageRoute(
          builder: (context) => const ProfilePrivacyCenterView(),
        );
      case Routes.chatBotView:
        return MaterialPageRoute(
          builder: (context) => const ChatBotView(),
        );
      case Routes.profileFaqView:
        return MaterialPageRoute(
          builder: (context) => const ProfileFaqView(),
        );
      case Routes.latestMedicalNewsView:
        return MaterialPageRoute(
          builder: (context) => LatestMedicalNewsView(
            articles: settings.arguments as List<ArticleEntity>,
          ),
        );
      case Routes.nearbyDoctorsListView:
        return MaterialPageRoute(
          builder: (context) => NearbyDoctorsListView(
            doctors: settings.arguments as List<DoctorEntity>,
          ),
        );

      case Routes.previewScanView:
        return MaterialPageRoute(
          builder: (context) => PreviewScanView(
              title: settings.arguments as String
          ),
        );
      case Routes.addPostView:
        return MaterialPageRoute(
          builder: (context) => const AddPostView(),
        );
      case Routes.personalInfoView:
        return MaterialPageRoute(
          builder: (context) => const PersonalInfoView(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
