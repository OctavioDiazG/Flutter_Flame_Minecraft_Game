import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:minecraft2d_game/global/global_game_reference.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class BlockComponent extends SpriteComponent{

  final Blocks block;
  final Vector2 blockIndex;
  final int chunkIndex;

  BlockComponent({required this.chunkIndex, required this.blockIndex, required this.block});

  @override
  Future<void> onLoad() async{
    super.onLoad();
    sprite = await GameMethods.instance.getSpriteFromBlock(block);

    add(RectangleHitbox());
  }

  @override
  void onGameResize(Vector2 newGameSize) {
    // TODO: implement onGameResize
    super.onGameResize(newGameSize);
    size = GameMethods.instance.blockSize;
    position = Vector2(
      GameMethods.instance.blockSize.x * blockIndex.x,
      GameMethods.instance.blockSize.y * blockIndex.y,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!GlobalGameReference.instance.gameReference.worldData.chunksThatShouldBeRendered.contains(chunkIndex)) {
        
      removeFromParent();

      GlobalGameReference.instance.gameReference.worldData.currentRenderedChunk.remove(chunkIndex);
    }
  }



}