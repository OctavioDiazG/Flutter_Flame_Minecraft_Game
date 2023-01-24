import 'package:flutter/material.dart';
import 'package:minecraft2d_game/widget/player_health_bar.dart';
import 'package:minecraft2d_game/widget/player_hunger_bar.dart';

class HungerAndHealthBar extends StatelessWidget {
  const HungerAndHealthBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [PlayerHealthBarWidget(), PlayerHungerBarWidget()],
      ),
    );
  }
}