import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 13.5),
        prefixIcon: SizedBox(
            height: 24,
            width: 24,
            child: Center(
              child: SvgPicture.asset(
                Assets.imagesSearchGrayIcon,
              ),
            )),
        filled: true,
        fillColor: const Color(0xffF2F4F7),
        hintText: 'Search',
        hintStyle:
            AppStyles.font14Regular.copyWith(color: const Color(0xff9E9E9E)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: Colors.transparent,
            )),
      ),
    );
  }
}
