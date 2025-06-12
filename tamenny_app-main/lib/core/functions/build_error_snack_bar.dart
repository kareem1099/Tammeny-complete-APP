import 'package:flutter/material.dart';

void showErrorBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      content: Text(message),
    ),
  );
}
