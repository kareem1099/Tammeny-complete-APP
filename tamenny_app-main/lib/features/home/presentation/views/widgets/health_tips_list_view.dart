import 'package:flutter/material.dart';
import 'package:tamenny_app/features/home/domain/entites/health_tip_entity.dart';
import 'package:tamenny_app/features/home/presentation/views/widgets/health_tips_item.dart';
import 'package:tamenny_app/generated/l10n.dart';

class HealthTipsListView extends StatelessWidget {
  const HealthTipsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<HealthTipEntity> healthTips = [
      HealthTipEntity(
          tip: S.of(context).drinkWaterDaily, icon: Icons.water_drop),
      HealthTipEntity(tip: S.of(context).getEnoughSleep, icon: Icons.bedtime),
      HealthTipEntity(
          tip: S.of(context).takeShortWalks, icon: Icons.directions_walk),
      HealthTipEntity(
          tip: S.of(context).eatFruitsVeggies, icon: Icons.emoji_nature),
      HealthTipEntity(
          tip: S.of(context).stretchDaily, icon: Icons.self_improvement),
      HealthTipEntity(
          tip: S.of(context).limitScreenTime, icon: Icons.visibility_off),
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: healthTips.length,
        itemBuilder: (context, index) {
          return HealthTipsItem(
            healthTipEntity: healthTips[index],
          );
        },
      ),
    );
  }
}
