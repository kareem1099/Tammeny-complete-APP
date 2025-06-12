import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomAppSwitch extends StatefulWidget {
  const CustomAppSwitch({super.key});

  @override
  State<CustomAppSwitch> createState() => _CustomAppSwitchState();
}

class _CustomAppSwitchState extends State<CustomAppSwitch> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        activeColor: Colors.white,
        inactiveThumbColor: Colors.white,
        activeTrackColor: AppColors.primaryColor,
        inactiveTrackColor: const Color(0xffD9DEE2),
        splashRadius: 1,
        value: isActive,
        onChanged: (value) {
          setState(() {
            isActive = value;
          });
        },
      ),
    );
  }
}
