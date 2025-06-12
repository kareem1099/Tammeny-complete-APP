import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/notification_item.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/notification_state.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/notifications_list_view.dart';

class NotificationViewBody extends StatelessWidget {
  const NotificationViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            const NotificationState(),
            const SizedBox(height: 32),
            Expanded(
              child: NotificationsListView(theme: theme),
            ),
          ],
        ));
  }
}
