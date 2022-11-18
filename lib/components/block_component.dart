import 'package:flame/components.dart';
import 'package:minecraft2d_game/resources/blocks.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class BlockComponent extends SpriteComponent{

  final Blocks block;

  BlockComponent({required this.block});

  @override
  Future<void> onLoad() async{
    super.onLoad();
    size = GameMethods.instance.blockSize;
    sprite = await GameMethods.instance.getSpriteFromBlock(block);
  }
}