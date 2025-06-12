import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamenny_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:tamenny_app/core/functions/build_error_snack_bar.dart';
import 'package:tamenny_app/core/functions/get_user_entity.dart';
import 'package:tamenny_app/core/services/get_it_service.dart';
import 'package:tamenny_app/core/theme/app_colors.dart';
import 'package:tamenny_app/core/theme/app_styles.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/core/widgets/custom_app_button.dart';
import 'package:tamenny_app/features/profiel/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tamenny_app/features/profiel/presentation/manager/edit_profile_cubit/edit_profile_state.dart';

class ProfileInfoViewBody extends StatefulWidget {
  const ProfileInfoViewBody({super.key});

  @override
  State<ProfileInfoViewBody> createState() => _ProfileInfoViewBodyState();
}

class _ProfileInfoViewBodyState extends State<ProfileInfoViewBody> {
  XFile? selectedImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // final user = getIt<UserCubit>().currentUser!;
    // nameController.text = user.name;
    // emailController.text = user.email;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = XFile(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final backgroundColor =
        isDark ? AppColors.darkBackgroundColor : Colors.white;
    final fillColor = isDark ? AppColors.darkCardColor : AppColors.grayColor;
    final borderColor =
        isDark ? AppColors.darkDividerColor : AppColors.deepGrayColor;
    final hintTextColor =
        isDark ? AppColors.darkSecondaryTextColor : const Color(0xffC2C2C2);
    final textColor = isDark ? AppColors.darkTextColor : Colors.black87;
    final shimmerBaseColor =
        isDark ? AppColors.darkDividerColor : Colors.grey[300]!;
    final shimmerHighlightColor =
        isDark ? AppColors.darkCardColor : Colors.grey[100]!;

    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          showErrorBar(context, message: 'profile data updated');
          updateUserImageUrl(state.imageUrl);
        } else if (state is EditProfileCancelled) {
          showErrorBar(context, message: 'cancelled');
        } else if (state is EditProfileError) {
          log(state.message);
          showErrorBar(context, message: state.message);
        }
      },
      builder: (context, state) {
        return Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 65,
                                  backgroundColor: backgroundColor,
                                  child: ClipOval(
                                    child: selectedImage == null
                                        ? CachedNetworkImage(
                                            imageUrl: getIt<UserCubit>()
                                                .currentUser!
                                                .userAvatarUrl,
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: shimmerBaseColor,
                                              highlightColor:
                                                  shimmerHighlightColor,
                                              child: Container(
                                                width: 130,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: shimmerBaseColor,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              width: 130,
                                              height: 130,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: isDark
                                                    ? AppColors.darkDividerColor
                                                    : Colors.grey,
                                              ),
                                              child: Icon(
                                                Icons.person,
                                                size: 60,
                                                color: isDark
                                                    ? AppColors.darkTextColor
                                                        .withOpacity(0.7)
                                                    : Colors.white,
                                              ),
                                            ),
                                          )
                                        : Image.file(
                                            File(selectedImage!.path),
                                            width: 130,
                                            height: 130,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: pickImage,
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? AppColors.darkCardColor
                                            : const Color(0xffF4F8FF),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: isDark
                                                ? Colors.black54
                                                : Colors.black12,
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: SvgPicture.asset(
                                        Assets.imagesPenEditIcon,
                                        color: isDark
                                            ? AppColors.darkTextColor
                                                .withOpacity(0.7)
                                            : null,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      TextField(
                        controller: nameController,
                        style:
                            AppStyles.font14Medium.copyWith(color: textColor),
                        decoration: InputDecoration(
                          hintText: getIt<UserCubit>().currentUser!.name,
                          hintStyle: AppStyles.font14Medium
                              .copyWith(color: hintTextColor),
                          fillColor: fillColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        style:
                            AppStyles.font14Medium.copyWith(color: textColor),
                        decoration: InputDecoration(
                          hintText: getIt<UserCubit>().currentUser!.email,
                          hintStyle: AppStyles.font14Medium
                              .copyWith(color: hintTextColor),
                          fillColor: fillColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: borderColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'When you set up your personal information settings, you should take care to provide accurate information.',
                        style: AppStyles.font12Regular.copyWith(
                          color: isDark
                              ? AppColors.darkSecondaryTextColor
                              : const Color(0xff757575),
                        ),
                      ),
                      const SizedBox(height: 54),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomAppButton(
                    text: 'Save',
                    onTap: () {
                      log('name -> ${nameController.text.trim()} ,\n email -> ${emailController.text.trim()}');
                      context.read<EditProfileCubit>().updateProfile(
                            userId: getIt<UserCubit>().currentUser!.uId,
                            newAvatar: selectedImage,
                            newEmail: emailController.text.trim(),
                            newUsername: nameController.text.trim(),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
