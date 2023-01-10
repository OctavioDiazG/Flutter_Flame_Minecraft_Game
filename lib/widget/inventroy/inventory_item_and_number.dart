import 'package:flame/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class InventoryItemAndNumberWidget extends StatelessWidget {
  const InventoryItemAndNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned (
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.all(GameMethods.instance.slotSize/4),
        child: SpriteWidget(sprite: GameMethods.instance.getSpriteFromBlock(Blocks.sand)),
      )
    );
  }
}