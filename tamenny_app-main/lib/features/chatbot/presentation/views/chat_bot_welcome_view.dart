import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/features/chatbot/presentation/views/widgets/chatbot_welcome_view_body.dart';

class ChatbotWelcomeView extends StatelessWidget {
  const ChatbotWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
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
          body: ChatbotWelcomeViewBody(),
        ),
      ),
    );
  }
}
