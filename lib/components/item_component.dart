import 'dart:html';

import 'package:flame/components.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class ItemComponent extends SpriteComponent {

  final Vector2 spawnBlockIndex;
  final Blocks block;
  
  ItemComponent({required this.spawnBlockIndex, required this.block});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;
    position = (spawnBlockIndex * GameMethods.instance.blockSize.x) + GameMethods.instance.blockSize / 2;
    sprite = await GameMethods.instance.getSpriteFromBlock(block);
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    size = GameMethods.instance.blockSize * 0.6;
  }
}