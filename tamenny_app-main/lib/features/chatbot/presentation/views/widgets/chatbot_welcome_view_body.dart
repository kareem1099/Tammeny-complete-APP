import 'package:flutter/material.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ChatbotWelcomeViewBody extends StatelessWidget {
  const ChatbotWelcomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  S.of(context).meetTamennyAiChatbot,
                  style: AppStyles.font26Bold,
                ),
                const SizedBox(height: 10),
                Text(
                  S.of(context).tamennyChatbotDescription,
                  style: AppStyles.font16Regular.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 20),
                _buildFeatureRow(
                  icon: Icons.check_circle,
                  text: S.of(context).askHealthQuestions,
                  context: context,
                ),
                const SizedBox(height: 10),
                _buildFeatureRow(
                  icon: Icons.check_circle,
                  text: S.of(context).getRecommendations,
                  context: context,
                ),
                const SizedBox(height: 10),
                _buildFeatureRow(
                  icon: Icons.check_circle,
                  text: S.of(context).learnHealthTopics,
                  context: context,
                ),
                const SizedBox(height: 30),
                Text(
                  S.of(context).howToUseChatbot,
                  style: AppStyles.font20Bold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${S.of(context).stepOneChatBot}\n${S.of(context).stepTwoChatBot}\n${S.of(context).stepThreeChatBot}',
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const Spacer(),
                CustomAppButton(
                  text: S.of(context).startChatting,
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Routes.chatBotView);
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _buildFeatureRow({
    required IconData icon,
    required String text,
    required BuildContext context,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: theme.textTheme.bodyMedium?.color,
            ),
          ),
        ),
      ],
    );
  }
}
