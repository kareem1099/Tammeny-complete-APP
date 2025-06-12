import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';
import 'package:tamenny_app/config/locale_notifier.dart';
import 'package:tamenny_app/config/theme_notifier.dart';
import 'package:tamenny_app/core/routes/app_router.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/generated/l10n.dart';

import 'core/services/get_it_service.dart';


class TamennyApp extends StatelessWidget {
  const TamennyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localeNotifier = Provider.of<LocaleNotifier>(context);

    return MaterialApp(
      navigatorObservers: [getIt<RouteObserver<PageRoute>>()],

      locale: localeNotifier.locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.currentTheme,
      darkTheme: darkTheme,
      themeMode: themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: Routes.splashView,
    );
  }
}
