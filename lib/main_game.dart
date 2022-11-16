import 'package:flame/game.dart';
import 'package:minecraft2d_game/components/player_component.dart';


class MainGame extends FlameGame{

  @override
  Future<void> onLoad() async{
    super.onLoad();
    add(PlayerComponent());
  }
}