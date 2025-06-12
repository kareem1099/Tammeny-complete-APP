import 'package:flutter/material.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';

class HomeViewCustomHeader extends StatelessWidget {
  const HomeViewCustomHeader({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: AppStyles.font18SemiBold,
      ),
    );
  }
}
