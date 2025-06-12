import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PostAction extends StatelessWidget {
  const PostAction({
    super.key,
    required this.iconPath,
    required this.counts,
    this.onTap,
    this.isLiked = false,
  });

  final String iconPath;
  final int counts;
  final VoidCallback? onTap;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: isLiked
              ? const Icon(Icons.favorite, color: Colors.red, size: 20)
              : SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                ),
        ),
        const SizedBox(width: 4),
        Text(
          '$counts',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
