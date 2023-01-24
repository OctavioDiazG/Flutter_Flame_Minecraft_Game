import 'package:flame/components.dart';
import 'package:minecraft2d_game/utils/game_methods.dart';


class BlockBreakingComponent extends SpriteAnimationComponent {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    size = GameMethods.instance.blockSize;
  }
}