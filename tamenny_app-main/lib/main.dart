import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tamenny_app/bloc_observer.dart';
import 'package:tamenny_app/config/cache_helper.dart';
import 'package:tamenny_app/config/locale_notifier.dart';
import 'package:tamenny_app/config/theme_notifier.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/routes/app_router.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/services/supabase_storage_service.dart';
import 'package:tamenny_app/features/auth/data/models/user_model.dart';
import 'package:tamenny_app/features/map/domain/repos/nearby_doctors_repo.dart';
import 'package:tamenny_app/features/map/presentation/manager/nearby_doctors_cubit/nearby_doctors_cubit.dart';
import 'package:tamenny_app/tamenny_app.dart';
import 'core/functions/check_auth_state_changes.dart';
import 'core/helper/notification_helper.dart';
import 'features/community/domain/repos/Recommendation_repo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SupabaseStorageService.initSupaBase();
  await NotificationService.instance.initialize();

  checkAuthStateChanges();
  await CacheHelper.init();
  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await setupGetIt();
  await getIt.isReady<RecommendationRepo>();
  final themeNotifier = ThemeNotifier();
  final localeNotifier = LocaleNotifier();
  await getIt.allReady();
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  await themeNotifier.loadThemeFromPrefs();
  await localeNotifier.loadLocaleFromPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: themeNotifier,
        ),
        ChangeNotifierProvider.value(
          value: localeNotifier,
        ),
        BlocProvider(
          create: (context) => getIt<UserCubit>(),
        ),
        BlocProvider(
          create: (context) => NearbyDoctorsCubit(
            getIt<NearbyDoctorsRepo>(),
          )..fetchNearbyDoctors(),
        ),
      ],
      child: TamennyApp(
        appRouter: AppRouter(),
      ),
    ),
  );
}
