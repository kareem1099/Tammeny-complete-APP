import 'package:flutter/material.dart';
import 'package:tamenny_app/generated/l10n.dart';

import '../../../../../core/theme/app_styles.dart';

class OrSignInWith extends StatelessWidget {
  const OrSignInWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xffE0E0E0),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            S.of(context).orSignInWith,
            style: AppStyles.font12Regular
                .copyWith(color: const Color(0xff9E9E9E)),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xffE0E0E0),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
