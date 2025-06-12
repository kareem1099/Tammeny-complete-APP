import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/notification_item.dart';

class NotificationsListView extends StatelessWidget {
  const NotificationsListView({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => Divider(
        indent: 40,
        endIndent: 40,
        thickness: 0.2,
        height: 40,
        color: theme.dividerColor,
      ),
      itemBuilder: (context, index) => const NotificationItem(),
    );
  }
}
