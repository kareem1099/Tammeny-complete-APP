import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/notification_view_body.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/unread_notifications_widget.dart';
import 'package:tamenny_app/generated/l10n.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: customAppBar(
        context,
        title: S.of(context).notification,
        actions: [
          const UnreadNoitifications(),
        ],
      ),
      body: const NotificationViewBody(),
    );
  }
}
