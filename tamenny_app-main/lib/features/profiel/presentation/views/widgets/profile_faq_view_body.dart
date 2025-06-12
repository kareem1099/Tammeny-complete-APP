import 'package:flutter/material.dart';
import 'package:tamenny_app/features/profiel/domain/entites/faq_item_entity.dart';
import 'package:tamenny_app/features/profiel/presentation/views/widgets/expanded_list_widget.dart';
import 'package:tamenny_app/generated/l10n.dart';

class ProfileFaqViewBody extends StatelessWidget {
  const ProfileFaqViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;

    List<FaqItemEntity> getFaqItems(BuildContext context) {
      final s = S.of(context);
      return [
        FaqItemEntity(title: s.faqQ1, content: s.faqA1),
        FaqItemEntity(title: s.faqQ2, content: s.faqA2),
        FaqItemEntity(title: s.faqQ3, content: s.faqA3),
        FaqItemEntity(title: s.faqQ4, content: s.faqA4),
        FaqItemEntity(title: s.faqQ5, content: s.faqA5),
        FaqItemEntity(title: s.faqQ6, content: s.faqA6),
        FaqItemEntity(title: s.faqQ7, content: s.faqA7),
        FaqItemEntity(title: s.faqQ8, content: s.faqA8),
        FaqItemEntity(title: s.faqQ9, content: s.faqA9),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Container(
        color: backgroundColor,
        child: ListView.separated(
          itemBuilder: (context, index) {
            final faq = getFaqItems(context)[index];
            return ExpandedListWidget(
              title: faq.title,
              content: faq.content,
            );
          },
          separatorBuilder: (context, index) => Divider(
            thickness: 1,
            height: 12,
            color: theme.dividerColor,
          ),
          itemCount: getFaqItems(context).length,
        ),
      ),
    );
  }
}
