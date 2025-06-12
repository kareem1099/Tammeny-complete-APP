import 'package:flutter/material.dart';
import 'package:tamenny_app/features/community/presentation/views/widgets/privacy_widget.dart';
import 'package:tamenny_app/generated/l10n.dart';

AppBar addPostAppBar(BuildContext context) => AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: const [PrivacyWidget()],
    );
