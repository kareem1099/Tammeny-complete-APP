import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/search_view_screen.dart';

Route createRouteToSearch() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const SearchView(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Slide from bottom
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
