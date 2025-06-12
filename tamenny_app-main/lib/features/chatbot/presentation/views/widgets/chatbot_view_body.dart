import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tamenny_app/core/services/chatbot_service.dart';
import 'package:tamenny_app/core/utils/app_assets.dart';
import 'package:tamenny_app/features/chatbot/presentation/views/widgets/message.dart';
import 'package:tamenny_app/generated/l10n.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../../core/services/get_it_service.dart';

class ChatbotViewBody extends StatefulWidget {
  const ChatbotViewBody({super.key});

  @override
  State<ChatbotViewBody> createState() => _ChatbotViewBodyState();
}

class _ChatbotViewBodyState extends State<ChatbotViewBody> {
  List messages = [];
  late TextEditingController messageController;
  late final GenerativeModel model;

  @override
  void initState() {
    messageController = TextEditingController();

    super.initState();
  }

  addMessage() async {
    final prompt = messageController.text.trim();
    if (prompt.isNotEmpty) {
      setState(() {
        messages.add({'text': prompt, 'sender': true});
      });
      messageController.clear();
      final content = [Content.text(prompt)];
      final response = await getIt<chatService>().getChatbotResponse(prompt);
      setState(() {
        messages.add({'text': response, 'sender': false});
      });
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return Message(
                text: messages[index]['text'],
                isSender: messages[index]['sender'],
              );
            },
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.cardColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: theme.cardColor,
                      hintText: S.of(context).sendMessage,
                      hintStyle: TextStyle(color: theme.hintColor),
                      contentPadding: const EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Assets.imagesAddMoreIcon,
                    colorFilter: ColorFilter.mode(
                      theme.iconTheme.color ?? Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: addMessage,
                  icon: SvgPicture.asset(
                    Assets.imagesSendMessageIcon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
