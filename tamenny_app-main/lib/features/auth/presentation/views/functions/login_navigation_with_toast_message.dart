import 'package:flutter/material.dart';

import '../../../../../core/functions/show_toast_message.dart';
import '../../../../../core/routes/routes.dart';

loginWithMessage(
    {required BuildContext context,
    required String msg,
    Color? backgroundColor}) {
  showToastMessage(
    msg: msg,
    backgroundColor: backgroundColor,
  );
  Navigator.pushReplacementNamed(
    context,
    Routes.bottomNavBarView,
  );
}
