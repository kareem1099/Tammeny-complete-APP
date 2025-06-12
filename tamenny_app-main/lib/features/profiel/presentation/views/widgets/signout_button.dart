import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tamenny_app/core/routes/routes.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/generated/l10n.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CustomAppButton(
      text: S.of(context).signOut,
      // icon: Icons.logout,
      onTap: () async {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: S.of(context).confirmSignOut,
          text: S.of(context).signOutPrompt,
          animType: QuickAlertAnimType.scale,
          titleAlignment: TextAlign.center,
          confirmBtnColor: theme.colorScheme.error,
          confirmBtnText: S.of(context).signOut,
          confirmBtnTextStyle: TextStyle(
            color: theme.colorScheme.onError,
            fontWeight: FontWeight.bold,
          ),
          barrierColor: Colors.black.withOpacity(0.4),
          backgroundColor: Colors.white,
          showCancelBtn: true,
          cancelBtnText: S.of(context).cancel,
          onConfirmBtnTap: () async {
            Navigator.of(context, rootNavigator: true).pop();
            try {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();

              final accessToken = await FacebookAuth.instance.accessToken;
              if (accessToken != null) {
                await FacebookAuth.instance.logOut();
              }

              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(Routes.loginView, (route) => false);
            } catch (e) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: S.of(context).error,
                text: S.of(context).signOutFailed,
                confirmBtnText: S.of(context).ok,
                confirmBtnColor: theme.colorScheme.primary,
              );
              print('Sign-out error: $e');
            }
          },
        );
      },
      bgColor: theme.colorScheme.error.withOpacity(0.1),
      textColor: theme.colorScheme.error,
    );
  }
}
