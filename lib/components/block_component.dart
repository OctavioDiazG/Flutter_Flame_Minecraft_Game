import 'package:flame/components.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class BlockComponent extends SpriteComponent{

  final Blocks block;
  final Vector2 blockIndex;

  BlockComponent({required this.blockIndex, required this.block});

  @override
  Future<void> onLoad() async{
    super.onLoad();
    sprite = await GameMethods.instance.getSpriteFromBlock(block);
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



}