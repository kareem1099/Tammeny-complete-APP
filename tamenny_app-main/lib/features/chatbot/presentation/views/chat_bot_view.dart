import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/core/widgets/custom_app_bar.dart';
import 'package:tamenny_app/features/chatbot/presentation/views/widgets/chatbot_view_body.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: customAppBar(context, title: 'Tamenny bot', actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.imagesMoreAppBarIcon,
            colorFilter: ColorFilter.mode(
              theme.iconTheme.color ?? Colors.white,
              BlendMode.srcIn,
            ),
          ),
        )
      ]),
      body: const ChatbotViewBody(),
    );
  }
}
