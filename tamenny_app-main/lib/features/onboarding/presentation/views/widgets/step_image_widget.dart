import 'package:flutter/material.dart';

class StepImageWidget extends StatelessWidget {
  const StepImageWidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Image.asset(
        imageUrl,
      ),
    );
  }
}
