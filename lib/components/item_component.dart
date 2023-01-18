import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/components/player_component.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/entity.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class ItemComponent extends Entity {

  final Vector2 spawnBlockIndex;
  final dynamic item;
  
  ItemComponent({required this.spawnBlockIndex, required this.item});


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BlockComponent && BlockData.getBlockDataFor(other.block).isCollidable) {
      super.onCollision(intersectionPoints, other);
    } else if (other is PlayerComponent) {

      if (GlobalGameReference.instance.gameReference.worldData.inventoryManager.addBlockToInventory(item)) {
        //remove item from world  
        GlobalGameReference.instance.gameReference.worldData.items.remove(this);
        //add item to inventory
        removeFromParent();
      }
    }
  }


  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    position = (spawnBlockIndex * GameMethods.instance.blockSize.x) + GameMethods.instance.blockSize / 4;
    animation = SpriteAnimation.spriteList([item is Blocks 
      ? GameMethods.instance.getSpriteFromBlock(item)
      : GameMethods.instance.getSpriteFromItem(item)], stepTime: 1);
  }

  @override
  void onGameResize(Vector2 newSize) {
    super.onGameResize(newSize);
    size = GameMethods.instance.blockSize * 0.6;
  }

  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    setAllCollisionsToFalse();
  }
}