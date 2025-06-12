import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/generated/l10n.dart';

class NoComments extends StatelessWidget {
  const NoComments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: SvgPicture.asset(
              Assets.imagesNoCommentIcon,
            ),
          ),
        ),
        Text(
          S.of(context).noCommentsText,
        ),
      ],
    ));
  }
}
