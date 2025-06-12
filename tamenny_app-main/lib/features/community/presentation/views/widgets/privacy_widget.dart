import 'package:flutter/material.dart';
import 'package:tamenny_app/generated/l10n.dart';

class PrivacyWidget extends StatelessWidget {
  const PrivacyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          S.of(context).public,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
