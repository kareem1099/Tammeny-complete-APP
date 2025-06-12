import 'package:flutter/material.dart';
import 'package:tamenny_app/features/splash/presentation/views/widgets/tamenny_start_up_animation.dart';

class LogoNameWithAnimation extends StatelessWidget {
  const LogoNameWithAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: TammenyStartupAnimation(),
    );
  }
}
