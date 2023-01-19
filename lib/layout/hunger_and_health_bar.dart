import 'package:flutter/material.dart';
import 'package:minecraft2d_game/widget/player_health_bar.dart';
import 'package:minecraft2d_game/widget/player_hunger_bar.dart';

class HungerAndHealthBarWidget extends StatelessWidget {
  const HungerAndHealthBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: const [
          PlayerHealthBarWidget(),
          PlayerHungerBarWidget(),
        ],
      ),
    );
  }
}