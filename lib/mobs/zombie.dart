import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:minecraft2d_game/components/block_component.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/resources/entity.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';

class Zombie extends Entity{
  Vector2 dimensions = Vector2(67,99);

  late SpriteSheet walkingSpriteSheet = SpriteSheet(
    image: Flame.images.fromCache('sprite_sheets/mobs/sprite_sheet_zombie.png'),
    srcSize: dimensions,
  );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is BlockComponent && BlockData.getBlockDataFor(other.block).isCollidable) {
      super.onCollision(intersectionPoints, other);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(RectangleHitbox());

    anchor = Anchor.bottomCenter;

    animation = walkingSpriteSheet.createAnimation(row: 2,stepTime: 0.2,);
  }

  @override
  void update(double dt) {
    super.update(dt);
    fallingLogic(dt);
    killEntityLogic();
    jumpingLogic();

    setAllCollisionsToFalse();
  }



  @override
  void onGameResize(Vector2 newScreenSize) {
    super.onGameResize(newScreenSize);

    size  = dimensions * ((GameMethods.instance.blockSize.x *2) / dimensions.y);
  }
}